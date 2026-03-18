# frozen_string_literal: true

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
        def parse_xml(xml_content)
          xml_content = fix_encoding(xml_content)
          xml_content = replace_xmlns(xml_content)
          xml_content = replace_relative_ns(xml_content)
          xml_content = replace_ea_xmlns(xml_content)

          from_xml(xml_content)
        end

        private

        def fix_encoding(xml_content)
          return xml_content if xml_content.valid_encoding?

          xml_content
            .encode("UTF-16be", invalid: :replace, replace: "?")
            .encode("UTF-8")
        end

        def replace_xmlns(xml_content)
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

        def replace_relative_ns(xml_content)
          # Use greedy quantifier with negated character class - no backtracking
          # because the literal 'xmlns="' that follows is not in the character class
          xml_content.gsub(
            /<([^>]*)xmlns="([^"]*)" targetNamespace="([^"]*)"([^>]*)>/,
            '<\1xmlns="\3" targetNamespace="\3"\4>'
          )
        end

        def replace_ea_xmlns(xml_content)
          # Use greedy quantifier with negated character class - no backtracking
          # because the literal 'xmlns="' that follows is not in the character class
          xml_content
            .gsub(
              /<GML:ApplicationSchema([^>]*)xmlns="([^"]*)"([^>]*)>/,
              '<GML:ApplicationSchema\1altered_xmlns="\2"\3>'
            )
            .gsub(
              /<CityGML:ApplicationSchema([^>]*)xmlns="([^"]*)"([^>]*)>/,
              '<CityGML:ApplicationSchema\1altered_xmlns="\2"\3>'
            )
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
