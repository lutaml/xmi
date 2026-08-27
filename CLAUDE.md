# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build, Test, and Development Commands

```bash
# Install dependencies
bundle install

# Run all tests
bundle exec rake spec
bundle exec rspec

# Run a single test file
bundle exec rspec spec/xmi/sparx/sparx_root_xmi2013_uml2013_spec.rb

# Run a specific test by line number
bundle exec rspec spec/xmi/sparx/sparx_root_xmi2013_uml2016_spec.rb:610

# Run linter with auto-correct
bundle exec rubocop -A --auto-gen-config

# Run both tests and linting (default rake task)
bundle exec rake

# Interactive console for experimentation
bin/console

# Benchmarks (dev tooling under Xmi::Performance)
bundle exec rake performance:quick    # fast, less accurate
bundle exec rake performance:json     # JSON output
```

### RuboCop toolchain note

`Gemfile.lock` is **gitignored** — each machine resolves its own versions, and CI installs lock-free (typically a newer RuboCop than a stale local lock resolves). If local rubocop disagrees with CI:

```bash
bundle update rubocop rubocop-ast rubocop-performance rubocop-rspec rubocop-rake
```

Use the `rubocop:disable-next Cop` directive form (not `disable-next-line`) — it is the form current RuboCop accepts and requires for single-statement disables.

## Architecture Overview

This gem converts XMI (XML Metadata Interchange) files into Ruby objects, specifically designed for Enterprise Architect generated XMI files.

### Core Dependencies

- **lutaml-model**: All serializable models inherit from `Lutaml::Model::Serializable`
- **nokogiri**: XML parsing backend

### Main Entry Point / Parse Pipeline

Every public parse door routes through one module, `Xmi::ParserPipeline`
(`lib/xmi/parser_pipeline.rb`):

- `Xmi.parse(xml)` — auto version detection
- `Xmi.parse_with_version(xml, version)`
- `Xmi::Parsing.parse(xml, options)` — IO coercion, `:version`/`:register`/`:model_class` options
- `Xmi::Sparx::Root.parse_xml(xml)` — also builds `Sparx::Index`

Pipeline steps: `FixEncoding` (repairs invalid UTF-8) → `InitVersioning` →
`ParseXml` (detects the version register, or uses `ctx[:register]` when a
door resolved one) → `BuildIndex` (Root hierarchy only — custom
`:model_class` models are skipped). Encoding repair runs no matter which
door a consumer picks; `parser_pipeline_spec.rb` pins this for all doors.

Adding a parse concern = adding a pipeline step, not editing doors.

### OMG Namespace Version Handling

OMG publishes XMI and UML specifications with dated namespace URIs (e.g., `http://www.omg.org/spec/XMI/20110701`, `20131001`, `20161101`). Documents of any version parse via per-version registers: `NamespaceDetector` scans the namespaces, `VersionRegistry.detect_register` picks the register (`V20110701` / `V20131001` / `V20161101`), and mixed-version documents extend the primary register's fallback chain. Model classes stay version-agnostic by using alias namespace classes that inherit from the 20131001 canonical versions.

### Enterprise Architect's Misuse of the `xmlns` Attribute

**This is a critical quirk to understand when working with EA-generated XMI.**

In standard XML, `xmlns` is a reserved attribute for namespace declarations. However, Enterprise Architect incorrectly uses `xmlns` as a **regular data attribute** on certain stereotype elements (e.g., `GML:ApplicationSchema`, `CityGML:ApplicationSchema`), storing arbitrary URI values unrelated to namespace declarations.

This violates XML conventions and creates parsing conflicts—XML libraries treat `xmlns` as reserved. The workaround: `Xmi::EaRoot` extension code generation renames `xmlns` to `altered_xmlns` when building classes from MDG XML, and models such as `Gml::ApplicationSchema` declare the `altered_xmlns` attribute directly.

```ruby
class ApplicationSchema < Lutaml::Model::Serializable
  attribute :altered_xmlns, :string  # renamed from xmlns
end
```

### EA Writes Attribute Names Verbatim

Some EA attributes are written in non-camelCase spellings that must be
mapped literally — "correcting" them breaks parsing. Examples:
`package_name` and `associationclass` on `<extendedProperties>` (all
lowercase, no case conversion), pinned by
`spec/xmi/sparx/element/extended_properties_spec.rb`.

### Namespace Architecture

Namespace classes are defined in:
- `lib/xmi/namespace/omg.rb` - OMG namespaces (XMI, UML, UmlDi, UmlDc)
- `lib/xmi/namespace/sparx.rb` - Sparx-specific profiles (SysPhS, GML, EaUml, CustomProfile, CityGML)
- `lib/xmi/namespace.rb` - `Xmi::Namespace::SCOPE`: the canonical 10-namespace scope shared by `Xmi::Root`'s xml block and `Sparx::Mappings::BaseMapping` (pinned by `spec/xmi/namespace_scope_spec.rb`)

Use version-agnostic alias classes that inherit from 20131001 versions:
```ruby
::Xmi::Namespace::Omg::Xmi   # => inherits from Xmi20131001
::Xmi::Namespace::Omg::Uml   # => inherits from Uml20131001
```

### Version Registers

`V20110701` / `V20131001` / `V20161101` are table entries: each calls
`Versioned.define_version(register_id:, namespaces:, fallbacks:)` and
keeps only its real delta (version-specific `Documentation`/`Extension`
classes plus a `register_models` table). Adding an XMI version = a new
table entry, not a new boilerplate file. `Versioned` (`lib/xmi/versioned.rb`)
creates the `Lutaml::Model::Register`, binds namespaces, and runs
registration; `VersionRegistry` (`lib/xmi/version_registry.rb`) maps
version strings → registers and extends fallback chains for
mixed-namespace documents.

### Custom Types with XML Namespace

Custom types in `lib/xmi/type.rb` declare their XML namespace using the `xml do ... end` block:

```ruby
class XmiId < Lutaml::Model::Type::String
  xml do
    namespace ::Xmi::Namespace::Omg::Xmi
  end
end
```

### Model Definition Pattern

Concrete UML classes inherit from `Xmi::Uml::Base`, which carries
the shared boilerplate (`skip_reference_registration`, `type` and
`id` attrs, UML namespace, and their `map_attribute` lines).
Subclasses declare only their unique attributes and the `root`
element name. Verified via spike: lutaml-model inherits `xml do`
block contents (namespace + map_attribute) from the parent class.

UML Diagram Interchange elements (Bounds, Waypoint, Diagram,
OwnedElement) inherit from `Xmi::UmlDi::Base` instead — same
pattern, different namespace.

`OwnedAttribute`, `OwnedEnd`, and `OwnedParameter` inherit from
`Xmi::Uml::ValueSpecs`, which owns their shared value-specification
surface: `uml_type` (`<type>` element) plus `upper_value` /
`lower_value` / `default_value` with their polymorphic mappings.
Inherited element mappings serialize before subclass mappings, so the
EA-parity order (type, lowerValue, upperValue) comes from the base —
subclasses declare only attributes.

```ruby
# lib/xmi/uml/my_element.rb
module Xmi
  module Uml
    class MyElement < Base
      attribute :name, :string

      xml do
        root "myElement"
        map_attribute "name", to: :name
      end
    end
  end
end
```

For backward compatibility, raw `Lutaml::Model::Serializable`
inheritance still works but is discouraged for new UML classes.
The small reference-holder classes (AnnotatedElement, MemberEnd,
Type, ImportedPackage) intentionally stay direct from Serializable
because they don't carry the type+id pair that Base provides.

### Dynamic Extension Loading

`Xmi::EaRoot.load_extension(xml_path)` dynamically generates Ruby classes from EA MDG extension XML files. This creates stereotype classes under `Xmi::EaRoot::{ModuleName}::{ClassName}` and updates `Root` mappings.

Extensions use `NamespaceRegistry` to look up or create namespace classes dynamically:
- Existing namespace URIs resolve to predefined classes
- New URIs create dynamic classes under `Xmi::Namespace::Dynamic::{ModuleName}`

### Polymorphic Dispatch

Two attributes use lutaml-model's polymorphic dispatch on `xmi:type`:

- `PackagedElement.packaged_element` (and `UmlModel.packaged_element`) — dispatches to typed subclasses (`UmlClass`, `Association`, `Interface`, `InstanceSpecification`, etc.). Map: `Xmi::Uml::PACKAGED_ELEMENT_POLYMORPHIC_MAP` in `lib/xmi/uml/packaged_element.rb`.
- `Slot.value`, `OwnedAttribute.upper_value`/`lower_value`/`default_value`, `OwnedEnd.upper_value`/`lower_value`/`default_value`, `OwnedParameter.upper_value`/`lower_value`/`default_value` — dispatch to ValueSpecification subclasses (`OpaqueExpression`, `LiteralString`, `LiteralInteger`, etc.). Map: `Xmi::Uml::VALUE_SPECIFICATION_POLYMORPHIC_MAP` in `lib/xmi/uml/value_specification.rb`.

**Fallback contract:** unknown or missing `xmi:type` resolves to the abstract base (`PackagedElement` / `ValueSpecification`) via the class_map's Hash default value — no crash. Locked in by `spec/xmi/uml/polymorphic_map_contract_spec.rb` and `spec/xmi/uml/polymorphic_robustness_spec.rb`. Two paths land at the base: a missing discriminator short-circuits upstream (the declared attribute type is used); an unknown discriminator hits the Hash default. Residual upstream gap — modelling `xmi:type` and unprefixed `type` as separate slots on one element — is tracked in lutaml-model#758.

### Key Files

| File | Purpose |
|------|---------|
| `lib/xmi.rb` | Main entry point, loads dependencies and configures XML adapter |
| `lib/xmi/parser_pipeline.rb` | The parse pipeline — the one module behind every public parse door |
| `lib/xmi/sparx.rb` | Module with autoload declarations for Sparx components |
| `lib/xmi/sparx/root.rb` | Main `Root` class with parsing and namespace normalization |
| `lib/xmi/root.rb` | Base `Root` class with common XMI attributes |
| `lib/xmi/uml.rb` | UML model autoload entries |
| `lib/xmi/uml/base.rb` | `Xmi::Uml::Base` — common boilerplate for UML classes |
| `lib/xmi/uml_di.rb` | UML Diagram Interchange autoload entries |
| `lib/xmi/uml_di/base.rb` | `Xmi::UmlDi::Base` — common boilerplate for UMLDI classes |
| `lib/xmi/uml/packaged_element.rb` | `PackagedElement` + `PACKAGED_ELEMENT_POLYMORPHIC_MAP` |
| `lib/xmi/uml/value_specification.rb` | `ValueSpecification` abstract base + `VALUE_SPECIFICATION_POLYMORPHIC_MAP` |
| `lib/xmi/uml/value_specs.rb` | `Xmi::Uml::ValueSpecs` — shared value surface for OwnedAttribute/OwnedEnd/OwnedParameter |
| `lib/xmi/ea_root.rb` | Dynamic extension loading from MDG XML |
| `lib/xmi/type.rb` | Custom types with namespace declarations (XmiId, XmiType, etc.) |
| `lib/xmi/namespace/omg.rb` | OMG namespace classes (XMI, UML, UmlDi, UmlDc) |
| `lib/xmi/namespace/sparx.rb` | Sparx-specific profile namespaces |
| `lib/xmi/namespace_registry.rb` | URI-to-class mapping for namespace lookup |
| `lib/xmi/versioned.rb` | Version-register DSL: `define_version` table entries + `register_models` helper |
| `lib/xmi/version_registry.rb` | Version string → register mapping, mixed-namespace fallback chains |

### Collection Value Maps

When mapping collection elements, use the standard `VALUE_MAP` pattern to handle nil/empty values:

```ruby
map_element "Element", to: :elements,
              value_map: {
                from: { nil: :empty, empty: :empty, omitted: :empty },
                to: { nil: :empty, empty: :empty, omitted: :empty }
              }
```

A shared constant is available at `Xmi::Sparx::VALUE_MAP`.

## Known Issues

Attribute deserialization in lutaml-model is not namespace-disjoint under element-level namespaces: same-local-name attributes in different namespaces collapse into one model slot, document-order dependent (last spelling wins). This affects modelling `xmi:type` (the XMI discriminator) and unprefixed `type` (Sparx's classifier reference) as separate attributes on one element — see the class docstring on `OwnedParameter`. Tracked in lutaml-model#758 with a repro; `spec/xmi/uml/owned_parameter_spec.rb` pins the current behavior in both input orders.

The `lutaml-model` gemspec constraint is itself pinned by `spec/xmi_gemspec_spec.rb` — changing the dependency range is a deliberate act that updates that spec.

## Limitations

This gem is designed for Enterprise Architect generated XMI files and may not work with XMI from other tools.
