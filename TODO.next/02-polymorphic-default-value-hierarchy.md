# 02 — Polymorphic DefaultValue / UpperValue / LowerValue (DESIGN ONLY)

**Status: DESIGN-ONLY — deferred. Requires user approval and a
separate PR. Migrated from `TODO.refactor/15` (2026-07-02).**

The polymorphic edge-case bug referenced in the original TODO has
been resolved (TODO 13 landed robust polymorphic dispatch); this
item is unblocked but waiting on user direction.

## Problem

`OwnedAttribute#default_value`, `OwnedAttribute#upper_value`,
`OwnedAttribute#lower_value`, `OwnedEnd#upper_value`,
`OwnedEnd#lower_value` are all typed narrowly:

```ruby
attribute :upper_value, UpperValue    # concrete class, value :string
attribute :lower_value, LowerValue    # concrete class, value :string
attribute :default_value, DefaultValue # concrete class, value :string
```

UML 2.5 §9.8 says each of these wraps a **ValueSpecification** —
the abstract supertype. Concrete subclasses include
`LiteralString`, `LiteralInteger`, `LiteralBoolean`,
`LiteralUnlimitedNatural`, `LiteralNull`, `OpaqueExpression`.

Real Sparx XMI emits:

```xml
<upperValue xmi:type="uml:LiteralUnlimitedNatural" value="*"/>
<lowerValue xmi:type="uml:LiteralInteger" value="0"/>
<defaultValue xmi:type="uml:LiteralString" value="anonymous"/>
```

Current modeling captures `value` as a string and the `xmi:type`
discriminator as another string. **No data is lost**, but the class
identity is always `UpperValue`/`LowerValue`/`DefaultValue` — the
xmi:type information lives in a parallel string attribute, not in
the type system.

This is the same kind of narrowing TODO 10 fixed for `Slot#value`.
For consistency, the same polymorphic dispatch should apply.

## Proposed shape

### Step 1: bring DefaultValue/UpperValue/LowerValue under ValueSpecification

Currently:

```
Serializable
├── DefaultValue
│   ├── UpperValue
│   └── LowerValue
└── ValueSpecification
    ├── OpaqueExpression
    ├── LiteralString
    └── ...
```

Target:

```
ValueSpecification
├── OpaqueExpression
├── LiteralString
├── LiteralInteger
├── LiteralBoolean
├── LiteralUnlimitedNatural
├── LiteralNull
├── DefaultValue        # legacy concrete wrapper, kept for back-compat
│   ├── UpperValue
│   └── LowerValue
```

DefaultValue keeps its own `root "defaultValue"` for standalone
serialization, but inherits `type` (with `polymorphic_class: true`)
from ValueSpecification.

### Step 2: change parent attribute declarations

```ruby
class OwnedAttribute
  attribute :upper_value, ValueSpecification, polymorphic: true
  attribute :lower_value, ValueSpecification, polymorphic: true
  attribute :default_value, ValueSpecification, polymorphic: true

  xml do
    map_element "upperValue", to: :upper_value, polymorphic: VALUE_SPEC_POLY_MAP
    map_element "lowerValue", to: :lower_value, polymorphic: VALUE_SPEC_POLY_MAP
    map_element "defaultValue", to: :default_value, polymorphic: VALUE_SPEC_POLY_MAP
  end
end
```

`VALUE_SPEC_POLY_MAP` is a shared constant (DRY — same map reused
across `Slot`, `OwnedAttribute`, `OwnedEnd`, possibly
`OwnedParameter`).

### Step 3: update existing tests

Tests that assert `.is_a?(UpperValue)` flip to `.is_a?(ValueSpecification)`.
The xmi:type discriminator is still readable via `.type`.

## Migration impact

### Breaking changes

1. `owned_attribute.upper_value` returns a `LiteralUnlimitedNatural`
   (or similar), not an `UpperValue`. Code using `is_a?(UpperValue)`
   breaks.
2. `UpperValue.new(value: "1")` still works (concrete class kept),
   but the constructed instance no longer round-trips through the
   polymorphic path. The wrapper element name (`<upperValue>`) is
   preserved because the parent's mapping controls it.

### Affected consumers

- **lutaml/ea transformer** (`build_upper_value`, `build_lower_value`):
  constructs `UpperValue.new(...)` directly. Still works after the
  change — these classes still exist. But the constructed instance
  has class identity `UpperValue`, while parsing the same XML yields
  `LiteralUnlimitedNatural`. Round-trip via parse → ea-construct →
  serialize is preserved, but parse → ea-construct-as-ValueSpec →
  serialize differs in class identity.

  **Mitigation:** change ea transformer to construct
  `LiteralUnlimitedNatural.new(...)` for upper bounds and
  `LiteralInteger.new(...)` for lower bounds. The constructed
  instance matches what parsing would produce.

- **lutaml/lutaml-uml**: search for `UpperValue`/`LowerValue`/
  `DefaultValue` references and update similarly.

## Risk

This is a multi-PR change:

- **PR A:** Make DefaultValue/UpperValue/LowerValue inherit from
  ValueSpecification. Additive — no behavior change.
- **PR B:** Change parent attribute declarations to polymorphic
  ValueSpecification. Update tests. This is the breaking change.
- **PR C:** Update ea transformer to construct literal subclasses.

PR A is risk-free. PR B and C need coordination.

## Why design-only for now

- TODO 13 surfaced a polymorphic edge-case bug (unknown xmi:type
  crashes). That bug must be fixed before adding more polymorphic
  attributes.
- The current modeling, while not strictly correct, doesn't lose
  data. The fix is semantic purity, not data correctness.
- Touching `OwnedAttribute`/`OwnedEnd` broadly is a higher-risk
  refactor than the audit was scoped to perform.

Land TODOs 12, 13, 14 first. Revisit after the polymorphic edge-case
bug is resolved (either via lutaml-model upstream fix or local
workaround).

## Open questions

- Should `DefaultValue`/`UpperValue`/`LowerValue` be deprecated
  (warn on construction) once polymorphic dispatch lands? Or kept
  indefinitely as semantic aliases?
- Should the shared `VALUE_SPEC_POLY_MAP` constant live in
  `Xmi::Uml::ValueSpecification` (as a class-level constant) or in
  a separate registry module?
