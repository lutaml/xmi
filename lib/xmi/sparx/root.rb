# frozen_string_literal: true

require "nokogiri"

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
        # This method performs several preprocessing steps to handle quirks in
        # Enterprise Architect generated XMI files before delegating to
        # Lutaml::Model for parsing.
        #
        # @param xml_content [String] The raw XMI XML content
        # @return [SparxRoot] The parsed Ruby object
        #
        # @see #fix_encoding
        # @see #normalize_omg_namespace_versions
        # @see #preprocess_xml
        def parse_xml(xml_content)
          xml_content = fix_encoding(xml_content)
          xml_content = normalize_omg_namespace_versions(xml_content)
          xml_content = preprocess_xml(xml_content)

          from_xml(xml_content)
        end

        private

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

        # Normalize OMG namespace versions to a canonical version (20131001).
        #
        # OMG publishes XMI and UML specifications with dated namespace URIs
        # (e.g., http://www.omg.org/spec/XMI/20110701, 20131001, 20161101).
        # While these represent different specification versions, the core
        # XMI structure is compatible across versions.
        #
        # This normalization allows the library to use a single set of model
        # classes regardless of which namespace version the input file uses.
        #
        # @param xml_content [String] The XML content
        # @return [String] The XML content with normalized namespace URIs
        #
        # @example Normalization
        #   # Before:
        #   xmlns:xmi="http://www.omg.org/spec/XMI/20110701"
        #   xmlns:uml="http://www.omg.org/spec/UML/20161101"
        #
        #   # After:
        #   xmlns:xmi="http://www.omg.org/spec/XMI/20131001"
        #   xmlns:uml="http://www.omg.org/spec/UML/20131001"
        def normalize_omg_namespace_versions(xml_content)
          # Single-pass replacement for all OMG namespace version normalizations
          # This avoids creating 4 intermediate string copies
          xml_content.gsub(
            %r{xmlns:(xmi|uml|umldc|umldi)="http://www\.omg\.org/spec/(XMI|UML)/\d{8}},
          ) do
            "xmlns:#{::Regexp.last_match(1)}=\"http://www.omg.org/spec/#{::Regexp.last_match(2)}/20131001"
          end
        end

        # Perform all Nokogiri-based preprocessing in a single parse pass.
        #
        # This method combines resolve_relative_namespaces and rename_ea_xmlns_attribute
        # into a single Nokogiri parse/modify/serialize cycle for better performance.
        #
        # == Resolve Relative Namespaces
        #
        # Some EA-generated XMI files define XML Schema elements with a
        # relative `xmlns` attribute value instead of an absolute URI.
        # The intended absolute URI is typically available in the
        # `targetNamespace` attribute of the same element.
        #
        # This method replaces relative xmlns values with the corresponding
        # targetNamespace value to ensure proper namespace resolution.
        #
        # @example Resolution
        #   # Before:
        #   <xs:schema xmlns="relative-path" targetNamespace="http://example.org/ns">
        #
        #   # After:
        #   <xs:schema xmlns="http://example.org/ns" targetNamespace="http://example.org/ns">
        #
        # == Rename EA's xmlns Attribute
        #
        # === Background: Enterprise Architect's Misuse of the xmlns Attribute
        #
        # In standard XML, the `xmlns` attribute has special meaning—it declares
        # the default namespace for an element and its descendants. The XML
        # specification reserves this attribute name for namespace declarations.
        #
        # However, Enterprise Architect (EA) incorrectly uses `xmlns` as a
        # *regular data attribute* on certain stereotype elements, storing
        # arbitrary URI values that have nothing to do with XML namespace
        # declarations. This is a violation of XML conventions and creates
        # parsing conflicts.
        #
        # === Affected Elements
        #
        # This quirk has been observed on:
        # - `GML:ApplicationSchema` (Geography Markup Language profile)
        # - `CityGML:ApplicationSchema` (City Geography Markup Language profile)
        #
        # === The Conflict
        #
        # Lutaml::Model, like most XML libraries, treats `xmlns` as a reserved
        # keyword for namespace handling. When an element has an attribute
        # literally named `xmlns`, the parser may:
        # - Interpret it as a namespace declaration (incorrect for EA's usage)
        # - Fail to expose it as a regular attribute
        # - Cause errors during serialization
        #
        # === The Solution
        #
        # This method renames the `xmlns` attribute to `altered_xmlns` before
        # parsing. The corresponding model classes (e.g., `Gml::ApplicationSchema`)
        # define an `altered_xmlns` attribute to receive this value.
        #
        # @example
        #   # Before (EA-generated):
        #   <GML:ApplicationSchema xmlns="http://some-value" targetNamespace="...">
        #
        #   # After preprocessing:
        #   <GML:ApplicationSchema altered_xmlns="http://some-value" targetNamespace="...">
        #
        # @param xml_content [String] The XML content
        # @return [String] The preprocessed XML content
        #
        # @see Xmi::Sparx::Gml::ApplicationSchema#altered_xmlns
        def preprocess_xml(xml_content)
          doc = Nokogiri::XML(xml_content, nil, nil, Nokogiri::XML::ParseOptions::DEFAULT_XML)

          # Resolve relative namespace URIs using targetNamespace
          doc.xpath("//*[@xmlns and @targetNamespace]").each do |element|
            target_ns = element["targetNamespace"]
            element["xmlns"] = target_ns if target_ns
          end

          # Rename EA's misuse of xmlns as data attribute on GML:ApplicationSchema
          doc.xpath("//GML:ApplicationSchema[@xmlns]",
                    "GML" => "http://www.sparxsystems.com/profiles/GML/1.0")
            .each do |element|
            element["altered_xmlns"] = element["xmlns"]
            element.delete("xmlns")
          end

          # Rename EA's misuse of xmlns as data attribute on CityGML:ApplicationSchema
          doc.xpath("//CityGML:ApplicationSchema[@xmlns]",
                    "CityGML" => "http://www.sparxsystems.com/profiles/CityGML/1.0")
            .each do |element|
            element["altered_xmlns"] = element["xmlns"]
            element.delete("xmlns")
          end

          save_options = Nokogiri::XML::Node::SaveOptions::NO_DECLARATION | Nokogiri::XML::Node::SaveOptions::AS_XML
          doc.to_xml(encoding: "UTF-8", save_with: save_options)
        end
      end

      @@default_mapping = <<~MAP # rubocop:disable Style/ClassVars
        namespace_scope [
          ::Xmi::Namespace::Omg::Xmi,
          ::Xmi::Namespace::Omg::Uml,
          ::Xmi::Namespace::Omg::UmlDi,
          ::Xmi::Namespace::Omg::UmlDc,
          ::Xmi::Namespace::Sparx::Extension,
          ::Xmi::Namespace::Sparx::SysPhS,
          ::Xmi::Namespace::Sparx::Gml,
          ::Xmi::Namespace::Sparx::EaUml,
          ::Xmi::Namespace::Sparx::CustomProfile,
          ::Xmi::Namespace::Sparx::CityGml
        ]

        map_element "Extension", to: :extension
        map_element "ModelicaParameter", to: :modelica_parameter
        map_element "import", to: :eauml_import, value_map: VALUE_MAP
        map_element "ApplicationSchema", to: :gml_application_schema, value_map: VALUE_MAP
        map_element "CodeList", to: :gml_code_list, value_map: VALUE_MAP
        map_element "DataType", to: :gml_data_type, value_map: VALUE_MAP
        map_element "Union", to: :gml_union, value_map: VALUE_MAP
        map_element "Enumeration", to: :gml_enumeration, value_map: VALUE_MAP
        map_element "Type", to: :gml_type, value_map: VALUE_MAP
        map_element "FeatureType", to: :gml_feature_type, value_map: VALUE_MAP
        map_element "property", to: :gml_property, value_map: VALUE_MAP
      MAP

      @@mapping ||= @@default_mapping # rubocop:disable Style/ClassVars

      xml do
        eval Xmi::Sparx::SparxRoot.class_variable_get(:@@mapping) # rubocop:disable Security/Eval
      end
    end
  end
end
