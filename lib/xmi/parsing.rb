# frozen_string_literal: true

module Xmi
  # Unified API for XMI parsing with version support
  #
  # This module provides a consistent interface for parsing XMI documents
  # with automatic version detection or explicit version specification.
  #
  # @example
  #   # Auto-detect version from XML
  #   doc = Xmi::Parsing.parse(xml_content)
  #
  # @example
  #   # Force specific version
  #   doc = Xmi::Parsing.parse(xml_content, version: "20131001")
  #
  module Parsing
    class << self
      # @api public
      # Parse XMI with automatic version detection
      #
      # @param xml [String, IO] XML content or stream
      # @param options [Hash] Parsing options
      # @option options [String] :version Force specific version
      # @option options [Lutaml::Model::Register] :register Use specific register
      # @option options [Class] :model_class Model class to parse into
      # @option options [Boolean] :strict Raise on unknown elements
      # @return [Root, Object] Parsed XMI document
      def parse(xml, options = {})
        xml_content = xml.respond_to?(:read) ? xml.read : xml.to_s

        Xmi.init_versioning! unless Xmi.versioning_initialized?

        register = determine_register(xml_content, options)
        model_class = options[:model_class] || Root

        if register
          model_class.from_xml(xml_content, register: register)
        else
          # Fallback to default parsing (existing behavior)
          model_class.from_xml(xml_content)
        end
      end

      # @api public
      # Parse XMI file
      #
      # @param path [String] File path
      # @param options [Hash] Parsing options
      # @return [Root, Object] Parsed XMI document
      def parse_file(path, options = {})
        parse(File.read(path), options)
      end

      # @api public
      # Detect XMI version without full parsing
      #
      # @param xml [String] XML content
      # @return [Hash] Version information with :versions and :uris keys
      def detect_version(xml)
        versions = NamespaceDetector.detect_versions(xml)
        uris = NamespaceDetector.detect_namespace_uris(xml)

        {
          versions: versions,
          uris: uris,
          xmi_version: versions[:xmi],
          uml_version: versions[:uml],
        }
      end

      # @api public
      # Get supported XMI versions
      #
      # @return [Array<String>]
      def supported_versions
        VersionRegistry.available_versions
      end

      # @api public
      # Check if a version is supported
      #
      # @param version [String] Version string (e.g., "20131001")
      # @return [Boolean]
      def version_supported?(version)
        supported_versions.include?(version)
      end

      private

      # Determine the appropriate register for parsing
      #
      # @param xml_content [String] XML content
      # @param options [Hash] Options hash
      # @return [Lutaml::Model::Register, nil]
      def determine_register(xml_content, options)
        # Explicit register takes precedence
        return options[:register] if options[:register]

        # Explicit version
        if options[:version]
          reg = VersionRegistry.register_for_version(options[:version])
          unless reg
            raise ArgumentError,
                  "Unknown version: #{options[:version]}"
          end

          return reg
        end

        # Auto-detect from XML content
        VersionRegistry.detect_register(xml_content)
      end
    end
  end
end
