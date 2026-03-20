# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
