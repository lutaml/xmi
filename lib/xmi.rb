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

require_relative "xmi/version"
require_relative "xmi/namespace"
require_relative "xmi/namespace/dynamic"
require_relative "xmi/type"
require_relative "xmi/namespace_detector"
require_relative "xmi/namespace_registry"
require_relative "xmi/xmi_identity"

module Xmi
  class Error < StandardError; end

  # Shared value_map for XMI elements
  # Used to handle nil, empty, and omitted values consistently
  VALUE_MAP = {
    from: { nil: :empty, empty: :empty, omitted: :empty },
    to: { nil: :empty, empty: :empty, omitted: :empty },
  }.freeze
end

# Bootstrap the namespace registry
Xmi::NamespaceRegistry.bootstrap!

# Version infrastructure
require_relative "xmi/versioned"
require_relative "xmi/version_registry"
require_relative "xmi/v20110701"
require_relative "xmi/v20131001"
require_relative "xmi/v20161101"

require_relative "xmi/add"
require_relative "xmi/delete"
require_relative "xmi/difference"
require_relative "xmi/documentation"
require_relative "xmi/extension"
require_relative "xmi/replace"
require_relative "xmi/ea_root"
require_relative "xmi/uml"
require_relative "xmi/custom_profile"
require_relative "xmi/root"
require_relative "xmi/sparx"

# Unified parsing API
require_relative "xmi/parsing"
require_relative "xmi/parser_pipeline"

module Xmi
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
      init_versioning!
      VersionRegistry.parse_with_detected_version(xml_content, Root)
    end

    # @api public
    # Parse XMI with a specific version register
    #
    # @param xml_content [String] XML content
    # @param version [String] Version string (e.g., "20131001")
    # @return [Root] Parsed XMI document
    def parse_with_version(xml_content, version)
      init_versioning!
      register = VersionRegistry.register_for_version(version)
      raise ArgumentError, "Unknown version: #{version}" unless register

      Root.from_xml(xml_content, register: register)
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
