# Migration Guide: Version-Aware Parsing

## Overview

This guide helps you migrate from the old XMI parsing API to the new version-aware parsing system.

## Old API (Pre-Versioning)

The old API used `SparxRoot.parse_xml` with automatic namespace normalization:

```ruby
require 'xmi'

# Old approach - normalizes all namespaces to 20131001
doc = Xmi::Sparx::SparxRoot.parse_xml(xml_content)
```

This approach:
- Preprocesses XML to normalize namespace versions
- Uses a single set of model classes
- Works for all XMI versions

## New API (Version-Aware)

The new API detects and uses the correct version automatically:

```ruby
require 'xmi'

# New approach - version-aware parsing
doc = Xmi.parse(xml_content)

# Or for Sparx EA files
doc = Xmi::Sparx::SparxRoot.parse_xml_with_versioning(xml_content)
```

This approach:
- Detects version from XML namespace
- Uses version-specific model classes when needed
- Falls back gracefully for shared types

## Quick Migration

### For Basic Parsing

```ruby
# Before
doc = Xmi::Sparx::SparxRoot.parse_xml(xml_content)

# After
doc = Xmi::Sparx::SparxRoot.parse_xml_with_versioning(xml_content)

# Or
doc = Xmi.parse(xml_content)
```

### For Version Detection

```ruby
# Before
# No built-in version detection

# After
info = Xmi::Parsing.detect_version(xml_content)
puts info[:xmi_version]  # => "20131001"
```

### For Explicit Version

```ruby
# Before
# No explicit version support

# After
doc = Xmi.parse_with_version(xml_content, "20131001")
```

## Benefits of Version-Aware Parsing

1. **Correct Types**: Version-specific models are used when structures differ
2. **No Preprocessing**: XML is parsed directly without modification
3. **Graceful Fallback**: Shared types work across versions
4. **Future Extensibility**: Easy to add new version support

## When to Use Each API

| Use Case | Recommended API |
|----------|----------------|
| Sparx EA files | `Xmi::Sparx::SparxRoot.parse_xml_with_versioning` |
| General XMI files | `Xmi.parse` |
| Version detection | `Xmi::Parsing.detect_version` |
| Known version | `Xmi.parse_with_version(xml, version)` |

## Backward Compatibility

The old `parse_xml` method still works but normalizes namespaces:

```ruby
# Old API - still supported
doc = Xmi::Sparx::SparxRoot.parse_xml(xml_content)

# This internally normalizes to 20131001 namespace
```

## Troubleshooting

### Version Not Detected

If version detection fails:

```ruby
# Check what was detected
info = Xmi::Parsing.detect_version(xml_content)

# Use explicit version if needed
doc = Xmi.parse_with_version(xml_content, "20131001")
```

### Type Resolution Fails

If a type isn't resolved correctly:

```ruby
# Initialize versioning explicitly
Xmi.init_versioning!

# Check what version was detected
info = Xmi::Parsing.detect_version(xml_content)

# Use explicit version
doc = Xmi.parse_with_version(xml_content, info[:xmi_version])
```

## API Comparison

| Old API | New API |
|---------|---------|
| `SparxRoot.parse_xml` | `SparxRoot.parse_xml_with_versioning` |
| (no detection) | `Xmi::Parsing.detect_version` |
| (no explicit) | `Xmi.parse_with_version` |
| `Xmi.parse` (not existed) | `Xmi.parse` (auto-detect) |
