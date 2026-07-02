# 01 — PackagedElement typed subclasses (Phase B remaining)

**Status: PARTIAL — Phase A landed (2026-07-03); Phase B (narrowing
attrs to subclasses) deferred.**

## What landed (Phase A)

Polymorphic dispatch on `PackagedElement.packaged_element` and
`UmlModel.packaged_element`. Each `<packagedElement xmi:type="uml:X">`
now parses to a corresponding `Xmi::Uml::X` subclass:

| xmi:type | Ruby class |
|---|---|
| uml:Class | `Xmi::Uml::UmlClass` |
| uml:Association | `Xmi::Uml::Association` |
| uml:Interface | `Xmi::Uml::Interface` |
| uml:InstanceSpecification | `Xmi::Uml::InstanceSpecification` |
| uml:DataType | `Xmi::Uml::DataType` |
| uml:PrimitiveType | `Xmi::Uml::PrimitiveType` |
| uml:Enumeration | `Xmi::Uml::Enumeration` |
| uml:Package | `Xmi::Uml::Package` |
| uml:Realization | `Xmi::Uml::Realization` |

Dispatch map: `Xmi::Uml::PACKAGED_ELEMENT_POLYMORPHIC_MAP` in
`lib/xmi/uml/packaged_element.rb`. Spec coverage:
`spec/xmi/uml/packaged_element_dispatch_spec.rb` (17 examples).

Subclasses currently inherit the **full union-bag attribute set**
from `PackagedElement`. Consumers can dispatch on `is_a?(Xmi::Uml::X)`
for type-specific behavior, but accessing the wrong attr on the wrong
type still returns nil/empty rather than raising.

## What's deferred (Phase B)

Narrow each subclass's attribute set to its UML-2.5-conformant subset.
Examples:

| Class | Valid attrs (today, all inherited) |
|---|---|
| UmlClass | owned_attribute, owned_operation, owned_comment, generalization, interface_realization, nested packaged_element |
| Association | owned_end, member_end, member_ends |
| InstanceSpecification | classifier, slot, specification |
| Interface | owned_operation, generalization |
| Enumeration | owned_literal |
| DataType | owned_attribute, owned_operation |
| PrimitiveType | (none) |
| Realization | supplier, client |
| Package | nested packaged_element |

After Phase B, `instance.owned_attribute` raises NoMethodError on an
InstanceSpecification — the type system catches the misuse at runtime.

## Why Phase B is deferred

- **Breaking change.** Every consumer that accesses attrs via the
  base `PackagedElement` type breaks. The `lutaml/ea` transformer
  walks packaged_element generically; it would need type-specific
  dispatch added.
- **Test churn.** Every Sparx fixture regression test that accesses
  `pe.owned_attribute` (etc.) on a generic PackagedElement needs
  updating.
- **Limited semantic gain.** Phase A already gives consumers the
  type tag. Phase B catches programming errors but doesn't enable
  new functionality.
- The original TODO.next/01 design doc proposed Phase A as
  "risk-free" and Phase B as the "breaking change." That framing
  holds.

## Rollout strategy for Phase B

1. Survey every consumer of `PackagedElement` attrs in `lutaml/ea`,
   `lutaml/lutaml-uml`, and downstream.
2. For each consumer, change to type-specific dispatch:
   ```ruby
   case pe
   when Xmi::Uml::UmlClass then pe.owned_attribute ...
   when Xmi::Uml::Association then pe.owned_end ...
   end
   ```
3. Once consumers are type-aware, narrow subclass attrs.
4. Remove the narrowed attrs from `PackagedElement`.

This is a multi-PR change. Each step should land separately so
bisect works.

## Open questions

- Should `Generalization` move from `packagedElement` to its own
  child element shape to match OMG XMI? Sparx uses both. Defer.
- How to handle EA's `uml:ExtensionEnd` and other Sparx-isms? Treat
  as subclasses of the closest OMG type.
- The polymorphic dispatch failure mode (unknown xmi:type raises
  TypeError) is locked in by `polymorphic_robustness_spec.rb`. Phase B
  doesn't fix this; it's a separate concern.
