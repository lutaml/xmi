# frozen_string_literal: true

module Xmi
  module Sparx
    class SparxRoot < Root
      attribute :modelica_parameter, SysPhS

      attribute :eauml_import, EaUml::Import, collection: true
      attribute :gml_application_schema, Gml::ApplicationSchema,
                collection: true
      attribute :gml_code_list, Gml::CodeList, collection: true
      attribute :gml_data_type, Gml::CodeList, collection: true
      attribute :gml_union, Gml::CodeList, collection: true
      attribute :gml_enumeration, Gml::CodeList, collection: true
      attribute :gml_type, Gml::CodeList, collection: true
      attribute :gml_feature_type, Gml::CodeList, collection: true
      attribute :gml_property, Gml::Property, collection: true

      attribute :extension, Extension
      attribute :model, Uml::UmlModel

      class << self
        # Parse XMI content into Ruby objects.
        #
        # This method uses automatic version detection to handle different XMI
        # namespace versions (e.g., XMI 20110701, 20131001, 20161101) and
        # their corresponding UML versions.
        #
        # @param xml_content [String] The raw XMI XML content
        # @return [SparxRoot] The parsed Ruby object
        #
        # @see Xmi.parse
        def parse_xml(xml_content)
          xml_content = fix_encoding(xml_content)
          Xmi.init_versioning!
          Xmi::VersionRegistry.parse_with_detected_version(xml_content, self)
        end

        # Fix invalid UTF-8 encoding in the XML content.
        #
        # Some EA-generated XMI files contain invalid UTF-8 byte sequences
        # that would cause parsing failures. This method replaces invalid
        # bytes with placeholder characters.
        #
        # @param xml_content [String] The raw XML content
        # @return [String] The XML content with valid UTF-8 encoding
        def fix_encoding(xml_content)
          return xml_content if xml_content.valid_encoding?

          xml_content
            .encode("UTF-16be", invalid: :replace, replace: "?")
            .encode("UTF-8")
        end
      end

      # Use the reusable BaseMapping class instead of eval hack
      xml SparxMappings::BaseMapping
    end
  end
end
