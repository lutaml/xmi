# frozen_string_literal: true

module Xmi
  # Registry for XMI version-specific model trees.
  #
  # Manages the mapping between XMI versions and their registers.
  #
  # @example
  #   # Get register for a specific version
  #   register = Xmi::VersionRegistry.register_for_version("20131001")
  #
  # @example
  #   # Detect version from XML
  #   register = Xmi::VersionRegistry.detect_register(xml_content)
  #
  module VersionRegistry
    # Map of version string => version module
    @versions = {
      "20110701" => nil,  # Set during V20110701 init
      "20131001" => nil,  # Set during V20131001 init
      "20161101" => nil, # Set during V20161101 init
    }.freeze

    class << self
      # @api public
      # Get register for a specific XMI version
      #
      # @param version [String] Version string (e.g., "20131001")
      # @return [Lutaml::Model::Register, nil]
      def register_for_version(version)
        version_module = @versions[version]
        return nil unless version_module

        version_module.register
      end

      # @api public
      # Get register for a namespace URI
      #
      # @param namespace_uri [String] The namespace URI
      # @return [Lutaml::Model::Register, nil]
      def register_for_namespace(namespace_uri)
        Lutaml::Model::GlobalContext.register_for_namespace(namespace_uri)
      end

      # @api public
      # Register a version module
      #
      # @param version [String] Version string
      # @param mod [Module] The version module
      # @return [void]
      def register_version(version, mod)
        @versions = @versions.merge(version => mod)
      end

      # @api public
      # Get all registered versions
      #
      # @return [Array<String>]
      def available_versions
        @versions.keys
      end

      # @api public
      # Get the version module for a version string
      #
      # @param version [String] Version string
      # @return [Module, nil]
      def version_module(version)
        @versions[version]
      end

      # @api public
      # Detect version from XML content and return appropriate register
      #
      # For mixed namespace documents (e.g., XMI=20131001, UML=20161101), this
      # extends the primary register's fallback chain to include registers for
      # additional namespace versions, enabling correct type resolution.
      #
      # @param xml_content [String] XML content
      # @return [Lutaml::Model::Register, nil]
      def detect_register(xml_content)
        versions = NamespaceDetector.detect_versions(xml_content)
        xmi_version = versions[:xmi]

        return nil unless xmi_version

        primary_register = register_for_version(xmi_version)
        return nil unless primary_register

        # Handle mixed namespace documents (e.g., XMI=20131001 but UML=20161101).
        # We need to ensure the primary register's fallback chain includes
        # registers for any additional namespace versions, and bind those
        # namespace URIs to the primary register so type resolution works.
        all_versions = [versions[:xmi], versions[:uml], versions[:umldi],
                        versions[:umldc]].compact.uniq

        extend_fallback_for_mixed_namespaces(primary_register, all_versions) if all_versions.length > 1

        primary_register
      end

      # @api public
      # Parse XML with automatic version detection
      #
      # @param xml_content [String] XML content
      # @param model_class [Class] The model class to parse into
      # @return [Object] Parsed model instance
      def parse_with_detected_version(xml_content, model_class)
        register = detect_register(xml_content)

        if register
          model_class.from_xml(xml_content, register: register)
        else
          # Fallback to default parsing (existing behavior)
          model_class.from_xml(xml_content)
        end
      end

      # Handle mixed namespace documents by binding additional namespace URIs
      # to the primary register and extending its fallback chain.
      #
      # The namespace binding allows the primary register to handle elements
      # from additional namespace versions. The fallback chain extension allows
      # type resolution for types that exist only in those additional registers.
      #
      # Cycles are prevented by checking that the additional register's fallback
      # chain doesn't include the primary register (which would create a cycle).
      #
      # @param primary_register [Lutaml::Model::Register] The primary register
      # @param all_versions [Array<String>] All detected namespace versions
      # @return [void]
      # rubocop:disable Metrics/CyclomaticComplexity
      def extend_fallback_for_mixed_namespaces(primary_register, all_versions)
        xmi_version = all_versions.first
        other_versions = all_versions.drop(1)

        other_versions.each do |ver|
          next if ver == xmi_version

          reg = register_for_version(ver)
          next unless reg

          # Bind additional namespace URIs to the primary register using
          # proper namespace classes from NamespaceRegistry.
          reg.bound_namespace_uris.each do |uri|
            next if primary_register.handles_namespace?(uri)

            ns_class = NamespaceRegistry.resolve(uri)
            next unless ns_class

            primary_register.bind_namespace(ns_class)
          end

          # Extend fallback chain only if it won't create a cycle.
          # A cycle would occur if reg's fallback chain includes primary_register.
          # We check this by seeing if primary_register.id appears in reg's fallback.
          primary_register.fallback << reg.id unless reg.fallback.include?(primary_register.id)
        end
      end
      # rubocop:enable Metrics/CyclomaticComplexity
    end
  end
end
