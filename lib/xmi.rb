# frozen_string_literal: true

require "lutaml/model"
require "lutaml/xml"

# Configure XML adapter
Lutaml::Model::Config.xml_adapter_type = :nokogiri

module Lutaml
  module Model
    class Serializable
      def type?(test_type)
        !!type ? type == test_type : false
      end
    end
  end
end

module Xmi
  autoload :VERSION, "xmi/version"
  autoload :Namespace, "xmi/namespace"
  autoload :Type, "xmi/type"
  autoload :NamespaceDetector, "xmi/namespace_detector"
  autoload :NamespaceRegistry, "xmi/namespace_registry"
  autoload :XmiIdentity, "xmi/xmi_identity"
  autoload :Versioned, "xmi/versioned"
  autoload :VersionRegistry, "xmi/version_registry"
  autoload :V20110701, "xmi/v20110701"
  autoload :V20131001, "xmi/v20131001"
  autoload :V20161101, "xmi/v20161101"
  autoload :Add, "xmi/add"
  autoload :Delete, "xmi/delete"
  autoload :Difference, "xmi/difference"
  autoload :Documentation, "xmi/documentation"
  autoload :Extension, "xmi/extension"
  autoload :Replace, "xmi/replace"
  autoload :EaRoot, "xmi/ea_root"
  autoload :Uml, "xmi/uml"
  autoload :UmlDi, "xmi/uml_di"

  class Error < StandardError; end

  # Shared value_map for XMI elements.
  #
  # Parsing (`from:`) stays flexible: nil / empty / omitted all map
  # to the symbol `:empty`, which the parser uses to materialise an
  # empty model on the attribute. This preserves absence-vs-empty
  # distinctions on the way IN.
  #
  # Serialization (`to:`) is generation-friendly: nil / empty /
  # omitted all map to `:omitted`, which means "do not emit the
  # element". This eliminates the post-processing step the ea gem
  # previously needed (XmlSanitizer) to strip truly-empty elements
  # that real Sparx XMI never carries.
  #
  # This is a breaking change from the previous symmetric VALUE_MAP
  # (which emitted `<child/>` for empty collections). Consumers that
  # relied on empty-element round-trip must update.
  VALUE_MAP = {
    from: { nil: :empty, empty: :empty, omitted: :empty },
    to: { nil: :omitted, empty: :omitted, omitted: :omitted },
  }.freeze
end

# Bootstrap the namespace registry
Xmi::NamespaceRegistry.bootstrap!

module Xmi
  # Lazy-loaded top-level modules — autoload avoids loading these
  # until their constants are actually referenced at runtime.
  autoload :CustomProfile, "xmi/custom_profile"
  autoload :Root, "xmi/root"
  autoload :Sparx, "xmi/sparx"
  autoload :Performance, "xmi/performance"

  # Unified parsing API
  autoload :Parsing, "xmi/parsing"
  autoload :ParserPipeline, "xmi/parser_pipeline"

  class << self
    # @api public
    # Initialize all version registers
    #
    # Call this during gem initialization or before first use.
    #
    # @return [void]
    def init_versioning!
      return if @versioning_initialized

      # Initialize versions in order (newest depends on older)
      V20110701.init_models!
      V20131001.init_models!
      V20161101.init_models!

      @versioning_initialized = true
    end

    # @api public
    # Parse XMI with automatic version detection
    #
    # @param xml_content [String] XML content
    # @return [Root] Parsed XMI document
    def parse(xml_content)
      ParserPipeline.run({ xml: xml_content, root_class: Root })[:root]
    end

    # @api public
    # Parse XMI with a specific version register
    #
    # @param xml_content [String] XML content
    # @param version [String] Version string (e.g., "20131001")
    # @return [Root] Parsed XMI document
    def parse_with_version(xml_content, version)
      register = VersionRegistry.register_for_version(version)
      raise ArgumentError, "Unknown version: #{version}" unless register

      ParserPipeline.run(
        { xml: xml_content, root_class: Root, register: register },
      )[:root]
    end

    # @api public
    # Check if versioning has been initialized
    #
    # @return [Boolean]
    def versioning_initialized?
      @versioning_initialized || false
    end
  end
end
