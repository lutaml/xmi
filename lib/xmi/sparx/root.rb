# frozen_string_literal: true

require "nokogiri"

module Xmi
  module Sparx
    class SparxRoot < Root # rubocop:disable Metrics/ClassLength
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
        # @see #resolve_relative_namespaces
        # @see #rename_ea_xmlns_attribute
        def parse_xml(xml_content)
          xml_content = fix_encoding(xml_content)
          xml_content = normalize_omg_namespace_versions(xml_content)
          xml_content = resolve_relative_namespaces(xml_content)
          xml_content = rename_ea_xmlns_attribute(xml_content)

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
          xml_content
            .gsub(%r{xmlns:xmi="http://www.omg.org/spec/XMI/\d{8}},
                  "xmlns:xmi=\"http://www.omg.org/spec/XMI/20131001")
            .gsub(%r{xmlns:uml="http://www.omg.org/spec/UML/\d{8}},
                  "xmlns:uml=\"http://www.omg.org/spec/UML/20131001")
            .gsub(%r{xmlns:umldc="http://www.omg.org/spec/UML/\d{8}},
                  "xmlns:umldc=\"http://www.omg.org/spec/UML/20131001")
            .gsub(%r{xmlns:umldi="http://www.omg.org/spec/UML/\d{8}},
                  "xmlns:umldi=\"http://www.omg.org/spec/UML/20131001")
        end

        # Resolve relative namespace URIs using targetNamespace.
        #
        # Some EA-generated XMI files define XML Schema elements with a
        # relative `xmlns` attribute value instead of an absolute URI.
        # The intended absolute URI is typically available in the
        # `targetNamespace` attribute of the same element.
        #
        # This method replaces relative xmlns values with the corresponding
        # targetNamespace value to ensure proper namespace resolution.
        #
        # @param xml_content [String] The XML content
        # @return [String] The XML content with resolved namespace URIs
        #
        # @example Resolution
        #   # Before:
        #   <xs:schema xmlns="relative-path" targetNamespace="http://example.org/ns">
        #
        #   # After:
        #   <xs:schema xmlns="http://example.org/ns" targetNamespace="http://example.org/ns">
        def resolve_relative_namespaces(xml_content)
          with_nokogiri_doc(xml_content) do |doc|
            doc.xpath("//*[@xmlns and @targetNamespace]").each do |element|
              target_ns = element["targetNamespace"]
              element["xmlns"] = target_ns if target_ns
            end
          end
        end

        # Rename the 'xmlns' attribute to 'altered_xmlns' on EA-specific elements.
        #
        # == Background: Enterprise Architect's Misuse of the xmlns Attribute
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
        # == Affected Elements
        #
        # This quirk has been observed on:
        # - `GML:ApplicationSchema` (Geography Markup Language profile)
        # - `CityGML:ApplicationSchema` (City Geography Markup Language profile)
        #
        # == The Conflict
        #
        # Lutaml::Model, like most XML libraries, treats `xmlns` as a reserved
        # keyword for namespace handling. When an element has an attribute
        # literally named `xmlns`, the parser may:
        # - Interpret it as a namespace declaration (incorrect for EA's usage)
        # - Fail to expose it as a regular attribute
        # - Cause errors during serialization
        #
        # == The Solution
        #
        # This method renames the `xmlns` attribute to `altered_xmlns` before
        # parsing. The corresponding model classes (e.g., `Gml::ApplicationSchema`)
        # define an `altered_xmlns` attribute to receive this value.
        #
        # @param xml_content [String] The XML content
        # @return [String] The XML content with renamed xmlns attributes
        #
        # @example
        #   # Before (EA-generated):
        #   <GML:ApplicationSchema xmlns="http://some-value" targetNamespace="...">
        #
        #   # After preprocessing:
        #   <GML:ApplicationSchema altered_xmlns="http://some-value" targetNamespace="...">
        #
        # @see Xmi::Sparx::Gml::ApplicationSchema#altered_xmlns
        def rename_ea_xmlns_attribute(xml_content)
          with_nokogiri_doc(xml_content) do |doc|
            # Handle GML:ApplicationSchema elements
            doc.xpath("//GML:ApplicationSchema[@xmlns]", "GML" => "http://www.sparxsystems.com/profiles/GML/1.0").each do |element|
              element["altered_xmlns"] = element["xmlns"]
              element.delete("xmlns")
            end

            # Handle CityGML:ApplicationSchema elements
            doc.xpath("//CityGML:ApplicationSchema[@xmlns]", "CityGML" => "http://www.sparxsystems.com/profiles/CityGML/1.0").each do |element|
              element["altered_xmlns"] = element["xmlns"]
              element.delete("xmlns")
            end
          end
        end

        # Helper method for Nokogiri XML document processing.
        #
        # Yields a Nokogiri document for modification, then serializes it
        # back to XML without the XML declaration.
        #
        # @param xml_content [String] The XML content to process
        # @yield [Nokogiri::XML::Document] The parsed document for modification
        # @return [String] The serialized XML without declaration
        def with_nokogiri_doc(xml_content)
          doc = Nokogiri::XML(xml_content, nil, nil, Nokogiri::XML::ParseOptions::DEFAULT_XML)
          yield doc
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
        map_element "import", to: :eauml_import,
                              value_map: {
                                from: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                },
                                to: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                }
                              }
        map_element "ApplicationSchema", to: :gml_application_schema,
                              value_map: {
                                from: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                },
                                to: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                }
                              }
        map_element "CodeList", to: :gml_code_list,
                              value_map: {
                                from: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                },
                                to: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                }
                              }
        map_element "DataType", to: :gml_data_type,
                              value_map: {
                                from: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                },
                                to: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                }
                              }
        map_element "Union", to: :gml_union,
                              value_map: {
                                from: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                },
                                to: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                }
                              }
        map_element "Enumeration", to: :gml_enumeration,
                              value_map: {
                                from: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                },
                                to: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                }
                              }
        map_element "Type", to: :gml_type,
                              value_map: {
                                from: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                },
                                to: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                }
                              }
        map_element "FeatureType", to: :gml_feature_type,
                              value_map: {
                                from: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                },
                                to: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                }
                              }
        map_element "property", to: :gml_property,
                              value_map: {
                                from: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                },
                                to: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                }
                              }
      MAP

      @@mapping ||= @@default_mapping # rubocop:disable Style/ClassVars

      xml do
        eval Xmi::Sparx::SparxRoot.class_variable_get("@@mapping") # rubocop:disable Security/Eval
      end
    end
  end
end
