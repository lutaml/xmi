# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- All parse entry points (`Xmi.parse`, `Xmi.parse_with_version`,
  `Xmi::Parsing.parse`, `Sparx::Root.parse_xml`) route through
  `ParserPipeline`. Encoding repair no longer depends on which entry
  point you pick — four of the five previously crashed on invalid
  UTF-8. The dead `Sparx::Root.fix_encoding` duplicate is removed
- The Root-level namespace scope is declared once
  (`Xmi::Namespace::SCOPE`) and shared by `Xmi::Root` and
  `Mappings::BaseMapping`; the two verbatim copies could drift
  silently
- The version modules (`V20110701`, `V20131001`, `V20161101`) declare
  their table entry via `Versioned.define_version` instead of
  repeating the register_id/namespace_classes/fallback_registers
  boilerplate; each file now carries only its genuine delta
- `OwnedAttribute`, `OwnedEnd`, and `OwnedParameter` inherit their
  shared value-specification surface (uml_type + upper/lower/default
  values + the four element mappings) from the new
  `Xmi::Uml::ValueSpecs` base; serialized element order is pinned to
  EA parity (type, lowerValue, upperValue)

### Fixed

- Gemspec: restore the optimistic `~> 0.8.17` constraint on
  `lutaml-model`. The `< 0.8.20` cap added in 0.7.2 protected against
  the 0.8.20 release, but that release has been yanked from
  RubyGems — the cap is obsolete. A regression test in
  `spec/xmi_gemspec_spec.rb` pins the constraint so the cap does not
  silently come back

### Added

- Spec coverage for `Xmi::Sparx::Element::ExtendedProperties` (schema,
  `associationclass` round-trip, literal EA attribute spelling)

## [0.7.1] - 2026-08-25

### Added

- `ExtendedProperties#associationclass` — parses EA's literal
  `associationclass="EAID_…"` reference on connector
  `<extendedProperties>`, linking a connector to its association class

### Changed

- RuboCop directive style migrated from disable/enable blocks to
  next-line directives across spec files and `version_registry.rb`

## [0.7.0] - 2026-08-25

### Added

- `PackagedElement#nested_classifier` with `<nestedClassifier>` mapping
  (Sparx EA nesting for classifiers owned by classes), covered by
  `Xmi::Sparx::Index` lookups

### Changed

- `OwnedAttribute`/`OwnedEnd`/`OwnedParameter` serialize `lowerValue`
  before `upperValue`, matching Sparx EA's element order. Serialization
  only — parsing accepts either order and is unaffected

### Documented

- `OwnedParameter#type` keeps its xmi-namespaced mapping, and the
  limitation is now stated in the code and pinned by specs.
  `xmi:type` is the XMI metaclass discriminator and `type` is Sparx's
  classifier reference — two different attributes. lutaml-model matches
  by local name, so it collapses them into one slot and only the last
  one read survives re-serialization. Keeping the slot namespaced
  preserves the discriminator; restoring Sparx's classifier reference is
  the Sparx exporter's job. Modelling both needs namespace-disjoint
  attribute deserialization upstream (lutaml-model#744).

## [0.6.2] - 2026-07-18

### Added

- `Xmi::Performance` namespace for benchmark tooling (`Helpers`, `Comparator`, `Runner`) with autoload
- Polymorphic dispatch contract specs asserting frozen + default-value behavior at the data level
- Fallback coverage for `OwnedAttribute#upper_value`, `OwnedEnd#upper_value`, `OwnedParameter#upper_value` (previously only `Slot#value` was tested)
- Round-trip coverage for `uml:Component` and unknown `xmi:type` discriminators
- `spec/xmi/performance_spec.rb` covering autoload, class cloning, and namespace independence

### Fixed

- Deep-freeze the inner `class_map` hash on both `PACKAGED_ELEMENT` and `VALUE_SPECIFICATION` polymorphic maps. The outer `.freeze` was shallow — the inner hash was mutable at runtime
- `cached_fixture` ivar caching bug: the cache lived on per-example `self` and was recreated empty on every call, defeating its purpose. Replaced with a top-level `FIXTURE_CONTENT_CACHE` constant

### Changed

- Performance task constants moved into `Xmi::Performance` namespace: `PerformanceComparator` → `Xmi::Performance::Comparator`, `PerformanceHelpers` → `Xmi::Performance::Helpers`, `BenchmarkRunner` → `Xmi::Performance::Runner`. Dual-load mechanism replaced with class cloning via `const_set`
- Data-drive dispatch and subclass-schema specs from the class_map so adding a subclass + map entry auto-gains coverage (OCP for the test layer)
- Replace `.send(...)` with `.public_send(...)` in sparx extension specs for safer dynamic dispatch
- Normalize `require_relative` to `require "xmi"` in 8 spec files for consistency with the rest of the suite
- Correct polymorphic map comment terminology (`default_proc` → `default value`) and document the two-path fallback

### Removed

- `lib/tasks/performance_helpers.rb`, `lib/tasks/performance_comparator.rb`, `lib/tasks/benchmark_runner.rb` (moved to `lib/xmi/performance/`)
- Top-level constants `PerformanceComparator`, `PerformanceHelpers`, `BenchmarkRunner`, `Term` (moved into `Xmi::Performance`)
- Stale `TODO.next/01` and `TODO 02` references from comments (scratchpads were deleted; Phase A explanations kept)

## [0.6.1] - 2026-07-09

### Added

- `Xmi::Uml::Component` subclass for `<packagedElement xmi:type="uml:Component">` (UML 2.5 §12.3)
- `uml:Component` entry in `PACKAGED_ELEMENT_POLYMORPHIC_MAP`
- Polymorphic dispatch fallback: unknown or missing `xmi:type` resolves to the abstract base class via `Hash` default value, avoiding the lutaml-model `Object.const_get(nil)` `TypeError` on real Sparx XMI containing types not yet modelled

### Added

- Namespace-bound registers for version-aware type resolution
- `Register#bind_namespace` for binding registers to namespaces
- `Register#resolve_in_namespace` for namespace-aware type lookup
- `Register#import_model_tree` for importing entire model trees
- `GlobalContext#register_for_namespace` for reverse namespace lookup
- Version-aware XML parsing in `Document#parse_element`
- `Xmi::Versioned` module for version-specific model organization
- `Xmi::Common` module for shared models
- `Xmi::VersionRegistry` for version management
- `Xmi::V20110701`, `Xmi::V20131001`, `Xmi::V20161101` version modules
- `Xmi::Parsing` unified API for version-aware parsing
- `Xmi.parse` and `Xmi.parse_with_version` convenience methods
- `Xmi::Parsing.detect_version` for version detection without full parsing
- `Xmi::Parsing.parse_file` for parsing XMI files
- `Xmi::Parsing.supported_versions` and `Xmi::Parsing.version_supported?`
- Version-aware type resolution during XML parsing
- Mixed namespace document support (XMI version may differ from UML version)
- `Xmi::VersionRegistry.detect_register` for auto-detecting mixed namespaces
- `Xmi::VersionRegistry.extend_fallback_for_mixed_namespaces` for fallback chain extension
- `Xmi::NamespaceRegistry` for namespace URI to class resolution

### Documentation

- `docs/versioning.md` - Added mixed namespace document handling section explaining how
  `detect_register` detects all namespace versions and extends the fallback chain
- `docs/versioning.md` - Added version-specific namespace binding documentation
- `docs/versioning.md` - Added mixed namespace fallback chain diagram

### Deprecated

- `Xmi::ReplaceXmlns` - use `Xmi.parse` instead

### Fixed

- Type resolution now considers XML namespace during parsing
- Version-specific models correctly resolved via fallback chain

## [0.4.0] - 2024-01-01

### Added

- Initial release with Sparx EA XMI parsing support
- Dynamic class generation from extension XML files
- Support for UML 2.5.1 namespace
