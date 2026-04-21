# 02: Read-Only Fast Mode (Skip Namespace Declaration Plan)

## Impact: HIGH (eliminates full tree walk before mapping starts)

## Problem

In lutaml-model's `ModelTransform#data_to_model` (lines 71-76), `build_input_declaration_plan` calls `collect_element_namespaces` which recursively walks **every element** in the parsed document — solely for round-trip namespace fidelity (preserving xmlns declarations for `to_xml`).

Most XMI consumers only parse (read) and never call `to_xml`. This full tree walk is wasted work.

## Fix

### In lutaml-model

Add a `parse_only: true` option to `from_xml` that skips namespace declaration plan collection:

```ruby
# model_transform.rb line 71
unless options.key?(:lutaml_parent) || options[:parse_only]
  input_declaration_plan = build_input_declaration_plan(root_element)
  # ...
end
```

### In xmi gem

Pass `parse_only: true` in `ParserPipeline::ParseXml` step:

```ruby
model_class.from_xml(ctx[:xml], register: register, parse_only: true)
```

If the user later calls `to_xml`, it works but without preserved input namespace declarations (acceptable for read-only use). If they need full round-trip, they opt out of `parse_only`.

## Files

- `lutaml-model/lib/lutaml/xml/model_transform.rb` — gate `build_input_declaration_plan` behind `parse_only` option
- `lib/xmi/parser_pipeline.rb` — pass `parse_only: true` in ParseXml step
