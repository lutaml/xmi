# 03 — Real Sparx InstanceSpecification fixture (FUTURE)

**Status: FUTURE — requires Sparx EA access to acquire the fixture.
Migrated from `TODO.refactor/16` (2026-07-02).**

## Problem

The fixture added in TODO.refactor/08
(`spec/fixtures/sparx-instance-specification.xmi`) is hand-authored
to match Sparx EA's mixed-prefix style. It is structurally faithful
but not byte-identical to real EA output.

Several details can drift between synthetic and real:

- Whitespace and indentation (tabs vs spaces, blank lines).
- Attribute ordering within an element.
- Presence of EA-specific boilerplate (`xmi:Documentation exporter="Enterprise Architect" exporterVersion="..."`).
- Sparx's `EAID_` GUID format (uppercase hex with underscores, vs.
  the synthetic lowercase).
- Inclusion of `<xrefs>` elements on slot values (Sparx adds
  cross-references for tracked links).
- The `<extensions>` element with EA-specific `<elements>` and
  `<connectors>` sections.

## Goal

Acquire a real Sparx EA export that contains at least one:

- `<packagedElement xmi:type="uml:InstanceSpecification">` with
  `<slot>` children carrying `<value>` of various `xmi:type`.
- `<interfaceRealization>` (strict OMG form, even though current
  Sparx collapses to `uml:Realization`).

Replace `sparx-instance-specification.xmi` with the real fixture,
or add it as a sibling file. Update parity specs to use the real
fixture.

## Acquisition

Requires Sparx EA access. Suggested steps:

1. In EA, create a small model with one Class, one
   InstanceSpecification, and one InterfaceRealization.
2. Publish to XMI (EA's "Publish to File" or "Export to XMI").
3. Trim sensitive content if any.
4. Commit the fixture with a `<!-- Exported from Sparx EA vX.Y on
   YYYY-MM-DD, trimmed for the lutaml/xmi test suite. -->` header.

## Verification

- Real fixture parses without error.
- All existing parity specs continue to pass (or are updated to
  match real content).
- Coverage of `<value>` `xmi:type` variants matches what real EA
  emits (OpaqueExpression is the common case; LiteralString for
  default values).
