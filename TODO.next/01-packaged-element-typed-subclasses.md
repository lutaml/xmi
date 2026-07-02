# 01 — PackagedElement typed subclasses (DESIGN ONLY)

**Status: DESIGN-ONLY — deferred. Requires user approval and a separate PR.**

Migrated from `TODO.refactor/11` (2026-07-02). The original audit
landed all behavioral changes; this design document remains as a
future direction.

## Problem

`Xmi::Uml::PackagedElement` (lib/xmi/uml/packaged_element.rb) is a
god class: 13 child-element attributes and 8+ root attributes, only
some of which apply to any given `xmi:type`. Examples:

| xmi:type | Valid child attrs (today, all allowed) |
|---|---|
| uml:Class | owned_attribute, owned_operation, owned_comment, generalization, interface_realization, nested packaged_element |
| uml:Association | owned_end, member_end, member_ends |
| uml:InstanceSpecification | slot, specification, classifier |
| uml:Interface | owned_operation, generalization |
| uml:Enumeration | owned_literal |
| uml:DataType | owned_attribute, owned_operation |
| uml:PrimitiveType | (none) |
| uml:Realization | supplier, client |
| uml:Generalization | general, specific |
| uml:Package | nested packaged_element |

The union-bag approach:

- Lets invalid combinations parse silently
  (e.g. `<packagedElement type="uml:Association"><ownedAttribute/>...`)
- Bloats the model — every Sparx file instantiates the full attribute
  set on every packaged element.
- Confuses readers (which attrs are "real" for this type?).
- Pushes type-specific behavior into consumers (they re-dispatch on
  `xmi:type` after parsing).

## Proposed shape

Use lutaml-model's polymorphic dispatch (pattern established in
`Slot#value` — see `lib/xmi/uml/slot.rb`).

### New class hierarchy

```
Xmi::Uml::PackagedElement              # abstract base
├── Xmi::Uml::Class                    # xmi:type=uml:Class
├── Xmi::Uml::Association              # xmi:type=uml:Association
├── Xmi::Uml::Interface                # xmi:type=uml:Interface
├── Xmi::Uml::InstanceSpecification    # xmi:type=uml:InstanceSpecification
├── Xmi::Uml::DataType                 # xmi:type=uml:DataType
├── Xmi::Uml::PrimitiveType            # xmi:type=uml:PrimitiveType
├── Xmi::Uml::Enumeration              # xmi:type=uml:Enumeration
├── Xmi::Uml::Package                  # xmi:type=uml:Package
├── Xmi::Uml::Realization              # xmi:type=uml:Realization
├── Xmi::Uml::Generalization           # xmi:type=uml:Generalization (if emitted as packagedElement)
└── ... (one per xmi:type EA emits)
```

### Base carries only common attrs

`PackagedElement` keeps: `type`, `id`, `name`, `visibility`,
`packaged_element` (recursion — itself polymorphic).

### Each subclass adds its type-specific attrs

```ruby
class Class < PackagedElement
  attribute :owned_attribute, OwnedAttribute, collection: true
  attribute :owned_operation, OwnedOperation, collection: true
  attribute :owned_comment, OwnedComment, collection: true
  attribute :generalization, AssociationGeneralization, collection: true
  attribute :interface_realization, InterfaceRealization, collection: true
  attribute :is_abstract, :boolean
  attribute :is_leaf, :boolean
  attribute :is_active, :boolean
end

class Association < PackagedElement
  attribute :owned_end, OwnedEnd, collection: true
  attribute :member_end, :string
  attribute :member_ends, MemberEnd, collection: true
  attribute :is_derived, :boolean
end

class InstanceSpecification < PackagedElement
  attribute :classifier, :string
  attribute :slot, Slot, collection: true
  attribute :specification, Specification
end
```

### Parent-side wiring

`PackagedElement.packaged_element` (the recursion) becomes polymorphic
on `xmi:type`. Consumers iterate `model.packaged_element` and get a
heterogeneous list of typed objects.

```ruby
attribute :packaged_element, PackagedElement, collection: true, polymorphic: true
```

with `polymorphic_map` covering every concrete subclass.

## Rollout strategy

Two-phase:

1. **Phase A (additive only).** Introduce the subclass hierarchy. Keep
   `PackagedElement` as the concrete union bag. The subclasses exist
   but aren't wired to parsing. Consumers can opt in.
2. **Phase B (switch dispatch).** Flip `packaged_element` to
   `polymorphic: true` with the new map. Update consumers. Delete the
   union-bag attrs from `PackagedElement`.

Phase A is risk-free. Phase B is the breaking change.

## Why design-only for now

- The audit listed this as "Future PR, not this one."
- It's a multi-day refactor with broad blast radius.
- The current union-bag pattern works (parses real Sparx, round-trips).
- Untested subclasses without fixture coverage would be speculative.

## Open questions

- Does lutaml-model's polymorphic dispatch handle namespaced
  discriminators (`xmi:type` as `XmiType`)? **Answer (post-TODO 10):
  yes — `Slot#value` proves the pattern works.**
- Should `Generalization` move from `packagedElement` to its own child
  element shape to match OMG XMI? Sparx uses both. Defer.
- How to handle EA's `uml:ExtensionEnd` and other Sparx-isms? Treat as
  subclasses of the closest OMG type.
