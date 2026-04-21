# 01: Eliminate Duplicate Nokogiri Parse

## Impact: HIGH (~30-50% parse time for large files)

## Problem

`ParserPipeline` parses XML twice:
1. `NamespaceDetector.detect_versions` → `Nokogiri::XML(xml_content)` + `collect_namespaces` — parses entire doc just to read root namespace URIs
2. `from_xml` → adapter.parse(xml_content) — parses again via lutaml-model

For the 3.5MB large fixture, this is the dominant cost.

## Fix

Extract namespace URIs from the first ~4KB of the XML string using regex, avoiding Nokogiri entirely for version detection.

```ruby
# Instead of:
doc = Nokogiri::XML(xml_content)
doc.collect_namespaces

# Use:
NS_REGEX = /xmlns:?(\\w*)=["']([^"']+)["']/
xml_content[0, 4096].scan(NS_REGEX).to_h { |prefix, uri| [prefix, uri] }
```

The namespace declarations are always on or near the root element, so scanning the first 4KB is sufficient.

## Files

- `lib/xmi/namespace_detector.rb` — replace `extract_namespace_uris` Nokogiri parse with regex
- `lib/xmi/namespace_detector.rb` — verify `detect_versions` still works
- `spec/xmi/parser_pipeline_spec.rb` — verify tests pass
