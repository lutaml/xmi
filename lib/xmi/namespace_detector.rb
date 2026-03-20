# frozen_string_literal: true

require "nokogiri"

module Xmi
  # Detects namespace versions from XMI XML content
  #
  # This class parses XMI files to extract namespace URIs and detect
  # the specific versions of XMI, UML, and other OMG specifications used.
  class NamespaceDetector
    VERSION_PATTERN = /(\d{8})/

    # Namespace URI patterns for OMG specifications
    NS_PATTERNS = {
      xmi: %r{http://www\.omg\.org/spec/XMI/(\d{8})},
      uml: %r{http://www\.omg\.org/spec/UML/(\d{8})},
      umldi: %r{http://www\.omg\.org/spec/UML/(\d{8})/UMLDI},
      umldc: %r{http://www\.omg\.org/spec/UML/(\d{8})/UMLDC},
    }.freeze

    # Detect all namespace versions from XML content
    #
    # @param xml_content [String] The XML content to parse
    # @return [Hash] A hash with namespace types as keys and version strings as values
    #   Example: { xmi: "20131001", uml: "20131001", umldi: nil, umldc: nil }
    def self.detect_versions(xml_content)
      namespaces = extract_namespace_uris(xml_content)
      {
        xmi: detect_version(namespaces, :xmi),
        uml: detect_version(namespaces, :uml),
        umldi: detect_version(namespaces, :umldi),
        umldc: detect_version(namespaces, :umldc),
      }
    end

    # Extract all namespace URIs from XML content
    #
    # @param xml_content [String] The XML content to parse
    # @return [Hash<String, String>] A hash mapping prefixes to namespace URIs
    def self.extract_namespace_uris(xml_content)
      doc = Nokogiri::XML(xml_content, &:noent)
      doc.collect_namespaces
    rescue Nokogiri::XML::SyntaxError
      {}
    end

    # Detect version for a specific namespace type
    #
    # @param namespaces [Hash<String, String>] The namespace URIs hash
    # @param type [Symbol] The namespace type (:xmi, :uml, :umldi, :umldc)
    # @return [String, nil] The version string (e.g., "20131001") or nil if not found
    def self.detect_version(namespaces, type)
      pattern = NS_PATTERNS[type]
      return nil unless pattern

      namespaces.each_value do |uri|
        match = uri.match(pattern)
        return match[1] if match
      end

      nil
    end

    # Get the full namespace URI for a detected version
    #
    # @param type [Symbol] The namespace type (:xmi, :uml, etc.)
    # @param version [String] The version string (e.g., "20131001")
    # @return [String, nil] The full namespace URI
    def self.build_namespace_uri(type, version)
      case type
      when :xmi
        "http://www.omg.org/spec/XMI/#{version}"
      when :uml
        "http://www.omg.org/spec/UML/#{version}"
      when :umldi
        "http://www.omg.org/spec/UML/#{version}/UMLDI"
      when :umldc
        "http://www.omg.org/spec/UML/#{version}/UMLDC"
      end
    end

    # Get detected namespace URIs for all detected versions
    #
    # @param xml_content [String] The XML content to parse
    # @return [Hash] A hash with namespace types as keys and URIs as values
    def self.detect_namespace_uris(xml_content)
      versions = detect_versions(xml_content)
      {
        xmi: versions[:xmi] ? build_namespace_uri(:xmi, versions[:xmi]) : nil,
        uml: versions[:uml] ? build_namespace_uri(:uml, versions[:uml]) : nil,
        umldi: if versions[:umldi]
                 build_namespace_uri(:umldi,
                                     versions[:umldi])
               end,
        umldc: if versions[:umldc]
                 build_namespace_uri(:umldc,
                                     versions[:umldc])
               end,
      }
    end

    # Check if the XML uses a specific namespace version
    #
    # @param xml_content [String] The XML content to check
    # @param type [Symbol] The namespace type
    # @param version [String] The version to check for
    # @return [Boolean] True if the XML uses the specified version
    def self.uses_version?(xml_content, type, version)
      detected = detect_versions(xml_content)
      detected[type] == version
    end

    # Get a summary of all namespaces and their versions in the XML
    #
    # @param xml_content [String] The XML content to analyze
    # @return [Hash] Detailed namespace information
    def self.analyze(xml_content)
      versions = detect_versions(xml_content)
      uris = detect_namespace_uris(xml_content)
      raw_namespaces = extract_namespace_uris(xml_content)

      {
        versions: versions,
        uris: uris,
        raw_namespaces: raw_namespaces,
        normalized_needed: normalization_needed?(versions),
      }
    end

    # Check if namespace normalization is needed
    #
    # @param versions [Hash] The detected versions hash
    # @return [Boolean] True if any namespace is not 20131001
    def self.normalization_needed?(versions)
      versions.values.any? { |v| v && v != "20131001" }
    end
  end
end
