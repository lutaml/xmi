# 04 — Shared base class for UML models (DESIGN ONLY)

**Status: DESIGN-ONLY. Not implemented. Awaiting user direction.**

## Problem

Every concrete UML class in `lib/xmi/uml/*.rb` redeclares the same
three pieces of boilerplate:

1. `skip_reference_registration` (perf optimization from commit `d2f1b9f`)
2. `attribute :type, ::Xmi::Type::XmiType` (the `xmi:type` discriminator)
3. `attribute :id, ::Xmi::Type::XmiId` (the `xmi:id`)
4. `namespace ::Xmi::Namespace::Omg::Uml` inside the `xml do` block

Across the ~20 concrete UML classes, that's ~80 lines of identical
boilerplate. Worse, the convention is informal — at least one class
(`Waypoint`) historically missed `skip_reference_registration`, and
another (`OwnedOperation`) historically missed the `namespace`
declaration. Both were fixed during the OwnedEnd schema-gap refactor,
but the next model added without these would silently regress.

The `Profile` module already has a `ProfileAttributes` concern that
demonstrates the pattern works for sharing attribute declarations
via `include`. But concerns only cover attributes, not `xml do`
block content.

## Proposal

Introduce `Xmi::Uml::Base`:

```ruby
module Xmi
  module Uml
    class Base < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId

      xml do
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
      end
    end
  end
end
```

Every concrete UML class inherits from `Base` instead of
`Serializable`:

```ruby
class OwnedAttribute < Base
  attribute :name, :string
  # ... no need to redeclare type, id, skip_reference_registration

  xml do
    root "ownedAttribute"
    # namespace inherited from Base
    # map_attribute "type"/"id" inherited
    map_attribute "name", to: :name
  end
end
```

## Risk: lutaml-model inheritance semantics

The big open question: **does lutaml-model's `xml do` block inherit
from the parent class?**

Empirically, `OpaqueExpression < ValueSpecification` (landed in
TODO 10) works — the subclass redeclares its xml block entirely.
But the question for `Base` is the inverse: can the subclass
**extend** the parent's xml block (add new mappings without
re-declaring namespace and the type/id map_attributes)?

This needs a spike. Two possible outcomes:

- **Inherits cleanly:** subclasses only declare their unique
  attributes and `root`. Massive DRY win, ~60 lines removed.
- **Does not inherit:** subclasses still need to redeclare
  `namespace` and the type/id mappings. Only attribute declarations
  DRY up. Smaller win (~20 lines).

Either outcome is an improvement. Spike first to know which.

## Affected classes

All concrete UML classes would change:

- `OwnedAttribute`, `OwnedOperation`, `OwnedParameter`, `OwnedEnd`,
  `OwnedLiteral`, `OwnedComment`, `OwnedElement`
- `PackagedElement`, `UmlModel`
- `MemberEnd`, `AssociationGeneralization`
- `DefaultValue`, `UpperValue`, `LowerValue`
- `Slot`, `OpaqueExpression`, `InterfaceRealization`, `Specification`
- `ValueSpecification`, `LiteralString`, `LiteralInteger`,
  `LiteralBoolean`, `LiteralUnlimitedNatural`, `LiteralNull`
- `Bounds`, `Waypoint`, `Diagram`, `AnnotatedElement`
- `Profile`, `ProfileApplication`, `ProfileApplicationAppliedProfile`
- `ImportedPackage`, `PackageImport`
- `Type`

`Profile` already has its own `ProfileAttributes` concern — the
`Base` class would absorb most of that concern's responsibilities.

## Migration approach

Phase A (additive, risk-free):

1. Add `Xmi::Uml::Base` with the boilerplate.
2. Spike the xml-inheritance question on one class
   (e.g. `OwnedLiteral`).
3. If inheritance works, migrate a handful of simple classes.
4. If not, document the finding and stop.

Phase B (broad migration):

1. Update every concrete class to inherit from `Base`.
2. Run full suite. Each class migration should be a separate commit
   so bisect works.

Phase C (cleanup):

1. Remove `ProfileAttributes` concern (its attrs move to `Base`).
2. Remove `skip_reference_registration` redeclarations on
   subclasses (they inherit it).
3. Update CLAUDE.md to document the new convention.

## Why design-only for now

- Broad blast radius: every UML model file changes.
- Depends on a lutaml-model behavior that hasn't been verified.
- The current duplication, while ugly, doesn't lose data or cause
  bugs — it's an aesthetic/maintenance cost, not a correctness one.
- TODO.next/01 (PackagedElement typed subclasses) is a bigger
  architectural change that would benefit from `Base` existing
  first. Land this before that, not after.

## Open questions

- Does lutaml-model inherit `xml do` mappings from parent classes?
- Should `Base` declare `root` (perhaps a default like
  `"Element"`), or leave that to subclasses?
- Should `ValueSpecification` itself inherit from `Base`, or stay
  direct-from-Serializable? (Currently the latter; if `Base` lands,
  `ValueSpecification` should also inherit for consistency.)
- The `ProfileAttributes` concern uses `included` hook to declare
  attrs on the including class. Should `Base` use the same pattern,
  or rely on standard Ruby inheritance?

## Verification

When implemented:

- `bundle exec rspec` stays at the current green baseline.
- Line count of `lib/xmi/uml/*.rb` drops measurably.
- The "every UML class declares skip_reference_registration" pattern
  is gone from concrete classes.
