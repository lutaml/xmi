# XMI Version Support

## Overview

XMI files come in different versions with different namespace URIs. This gem handles version differences through namespace-bound registers that enable version-aware type resolution.

## Version-Specific Models

Some XMI elements differ between versions:

| Element | XMI 2.1 | XMI 2.5.1 | XMI 2.5.2 |
|---------|----------|------------|------------|
| Extension | v1 | v1 (reused) | v2 |
| Documentation | v1 | v2 | v2 (reused) |
| Model | v1 | v1 (reused) | v1 (reused) |

Where versions differ, the gem uses version-specific model classes through a fallback chain.

## Fallback Chain

```
xmi_20161101
    ↓ fallback
xmi_20131001
    ↓ fallback
xmi_20110701
    ↓ fallback
xmi_common
    ↓ fallback
default
```

Types not found in a version register fall back to older versions.

## Using Version-Aware Parsing

### Automatic Version Detection

```ruby
require 'xmi'

# Parse with automatic version detection
doc = Xmi.parse(xml_content)

# Get version information
info = Xmi::Parsing.detect_version(xml_content)
info[:xmi_version]  # => "20131001"
info[:uml_version]  # => "20131001"
info[:uris][:xmi]  # => "http://www.omg.org/spec/XMI/20131001"
```

### Explicit Version

```ruby
# Parse with explicit version
doc = Xmi.parse_with_version(xml_content, "20131001")

# Check supported versions
Xmi::Parsing.supported_versions  # => ["20110701", "20131001", "20161101"]
Xmi::Parsing.version_supported?("20131001")  # => true
```

### Sparx EA Files

```ruby
# For Enterprise Architect generated XMI files
doc = Xmi::Sparx::Root.parse_xml_with_versioning(xml_content)
```

## Version Modules

The gem provides version-specific modules:

```ruby
# XMI 2.1 (20110701)
Xmi::V20110701.register  # Register for this version
Xmi::V20110701::Extension  # Version-specific model
Xmi::V20110701::Documentation  # Version-specific model

# XMI 2.5.1 (20131001)
Xmi::V20131001.register
Xmi::V20131001::Documentation  # Different from V20110701

# XMI 2.5.2 (20161101)
Xmi::V20161101.register
Xmi::V20161101::Extension  # Different from previous versions
```

## Register Fallback Resolution

You can resolve types through the fallback chain:

```ruby
# Initialize versioning
Xmi.init_versioning!

# Get register for a version
register = Xmi::V20131001.register

# Resolve type with namespace awareness
klass = register.resolve_in_namespace(
  :extension,
  "http://www.omg.org/spec/XMI/20131001"
)
# Returns Xmi::V20110701::Extension (found via fallback)
```

### Mixed namespace documents

XMI documents frequently use different namespace versions for XMI, UML, UMLDI, and
UMLDC. For example, an XMI 2.5.1 file may declare:

```xml
<xmi:XMI xmlns:xmi="http://www.omg.org/spec/XMI/20131001"
         xmlns:uml="http://www.omg.org/spec/UML/20161101">
```

The XMI namespace is version 20131001, but the UML namespace is 20161101.
This gem handles mixed namespace documents automatically through the
`Xmi::VersionRegistry.detect_register` method.

#### How mixed namespace detection works

`detect_register` performs these steps:

1. **Detect all namespace versions** from the document's namespace declarations:
   - XMI namespace version (e.g., 20131001)
   - UML namespace version (e.g., 20161101)
   - UMLDI namespace version (if present)
   - UMLDC namespace version (if present)

2. **Get the primary register** for the XMI namespace version (the primary register
   determines the overall model tree structure).

3. **Extend the fallback chain** for additional namespace versions:
   - Bind the additional namespace URIs to the primary register using proper
     `Lutaml::Xml::Namespace` subclasses from the namespace registry.
   - Add the additional register to the primary register's fallback chain, so
     type resolution can find version-specific types.

4. **Prevent cycles**: If the additional register's fallback chain already
   includes the primary register, no extension is made. This prevents infinite
   loops in type resolution.

```ruby
# Detect mixed namespaces and get configured register
register = Xmi::VersionRegistry.detect_register(xml_content)
# The returned register:
# - Is bound to all namespace URIs present in the document
# - Has an extended fallback chain for additional version registers
# - Resolves types correctly regardless of which namespace they appear in

doc = ModelClass.from_xml(xml_content, register: register)
```

#### Fallback chain extension for mixed namespaces

Given a document with XMI=20131001 and UML=20161101, the register's fallback chain
is extended as follows:

```
Primary: xmi_20131001
  Handles: XMI 20131001, UML 20131001 namespaces

  Extended fallback: xmi_20161101 (added because UML=20161101 was detected)
    Handles: XMI 20161101, UML 20161101 namespaces
    Own fallback: xmi_20131001 (already has XMI 20131001)
```

This allows the parser to resolve:

- Types specific to the UML 20161101 version (via the extended fallback)
- Types from the primary XMI 20131001 version (via the primary register)

### Version-specific namespace binding

Each version register is bound to its specific namespace URIs:

```ruby
register = Xmi::V20131001.register
register.bound_namespace_uris
# => ["http://www.omg.org/spec/XMI/20131001",
#      "http://www.omg.org/spec/UML/20131001",
#      "http://www.omg.org/spec/UML/20131001/UMLDI",
#      "http://www.omg.org/spec/UML/20131001/UMLDC"]

register.handles_namespace?("http://www.omg.org/spec/XMI/20131001")
# => true

register.handles_namespace?("http://www.omg.org/spec/XMI/20161101")
# => false (different version)
```

## Programmatic Version Detection

```ruby
require 'xmi'

# Detect version from XML content
xml = <<~XML
  <?xml version="1.0"?>
  <xmi:XMI xmlns:xmi="http://www.omg.org/spec/XMI/20110701"
           xmlns:uml="http://www.omg.org/spec/UML/20110701">
    <xmi:Documentation>...</xmi:Documentation>
  </xmi:XMI>
XML

info = Xmi::Parsing.detect_version(xml)
# => { versions: { xmi: "20110701", uml: "20110701", ... },
#      uris: { xmi: "http://...", uml: "http://...", ... },
#      xmi_version: "20110701", uml_version: "20110701" }
```

## Error Handling

Unknown versions are handled gracefully:

```ruby
# Unknown version raises ArgumentError when explicitly specified
Xmi.parse_with_version(xml, "19990101")
# => ArgumentError: Unknown version: 19990101

# Unknown version falls back to default parsing when auto-detected
doc = Xmi.parse(unknown_version_xml)
# Works, but may not resolve version-specific types correctly
```

## API Reference

### Module Methods

| Method | Description |
|--------|-------------|
| `Xmi.parse(xml)` | Parse with auto-detection |
| `Xmi.parse_with_version(xml, version)` | Parse with explicit version |
| `Xmi.init_versioning!` | Initialize all version registers |
| `Xmi.versioning_initialized?` | Check initialization status |

### Parsing Module Methods

| Method | Description |
|--------|-------------|
| `Xmi::Parsing.parse(xml, **options)` | Parse with options |
| `Xmi::Parsing.parse_file(path, **options)` | Parse from file |
| `Xmi::Parsing.detect_version(xml)` | Detect version info |
| `Xmi::Parsing.supported_versions` | List supported versions |
| `Xmi::Parsing.version_supported?(version)` | Check if version supported |

### Version Registry Methods

| Method | Description |
|--------|-------------|
| `Xmi::VersionRegistry.register_for_version(version)` | Get register for version |
| `Xmi::VersionRegistry.register_for_namespace(uri)` | Get register for namespace |
| `Xmi::VersionRegistry.detect_register(xml)` | Detect and get register |
