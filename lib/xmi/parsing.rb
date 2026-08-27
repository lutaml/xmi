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
        xml_content = xml.is_a?(String) ? xml : xml.read

        ctx = {
          xml: xml_content,
          root_class: options[:model_class] || Root,
        }
        register = explicit_register(options)
        ctx[:register] = register if register

        ParserPipeline.run(ctx)[:root]
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

      # Resolve an explicitly requested register from options
      #
      # Returns nil when neither :register nor :version is given, leaving
      # version detection to the pipeline.
      #
      # @param options [Hash] Options hash
      # @return [Lutaml::Model::Register, nil]
      def explicit_register(options)
        return options[:register] if options[:register]

        return unless options[:version]

        VersionRegistry.register_for_version(options[:version]) ||
          raise(ArgumentError, "Unknown version: #{options[:version]}")
      end
    end
  end
end
