# frozen_string_literal: true

module Xmi
  module Sparx
    module SparxMappings
      # Base XML mapping class for Sparx EA XMI documents.
      #
      # This reusable mapping class encapsulates all the XML element → attribute
      # mappings for SparxRoot, eliminating the previous eval hack.
      #
      # @example Use in a model class
      #   class SparxRoot < Root
      #     xml SparxMappings::BaseMapping
      #   end
      #
      # @example Extend with additional mappings
      #   class ExtendedRoot < Root
      #     xml SparxMappings::GmlMapping
      #   end
      class BaseMapping < Lutaml::Xml::Mapping
        xml do
          # Set the default namespace for element name resolution
          namespace ::Xmi::Namespace::Omg::Xmi

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
            ::Xmi::Namespace::Sparx::CityGml,
          ]

          # Extension element containing Sparx EA-specific metadata
          map_element "Extension", to: :extension

          # Modelica parameter elements (SysPhS profile)
          map_element "ModelicaParameter", to: :modelica_parameter

          # UML import elements (EAUML profile)
          map_element "import", to: :eauml_import,
                                value_map: {
                                  from: {
                                    nil: :empty,
                                    empty: :empty,
                                    omitted: :empty,
                                  },
                                  to: {
                                    nil: :empty,
                                    empty: :empty,
                                    omitted: :empty,
                                  },
                                }

          # GML ApplicationSchema elements
          map_element "ApplicationSchema", to: :gml_application_schema,
                                           value_map: {
                                             from: {
                                               nil: :empty,
                                               empty: :empty,
                                               omitted: :empty,
                                             },
                                             to: {
                                               nil: :empty,
                                               empty: :empty,
                                               omitted: :empty,
                                             },
                                           }

          # GML CodeList elements
          map_element "CodeList", to: :gml_code_list,
                                  value_map: {
                                    from: {
                                      nil: :empty,
                                      empty: :empty,
                                      omitted: :empty,
                                    },
                                    to: {
                                      nil: :empty,
                                      empty: :empty,
                                      omitted: :empty,
                                    },
                                  }

          # GML DataType elements
          map_element "DataType", to: :gml_data_type,
                                  value_map: {
                                    from: {
                                      nil: :empty,
                                      empty: :empty,
                                      omitted: :empty,
                                    },
                                    to: {
                                      nil: :empty,
                                      empty: :empty,
                                      omitted: :empty,
                                    },
                                  }

          # GML Union elements
          map_element "Union", to: :gml_union,
                               value_map: {
                                 from: {
                                   nil: :empty,
                                   empty: :empty,
                                   omitted: :empty,
                                 },
                                 to: {
                                   nil: :empty,
                                   empty: :empty,
                                   omitted: :empty,
                                 },
                               }

          # GML Enumeration elements
          map_element "Enumeration", to: :gml_enumeration,
                                     value_map: {
                                       from: {
                                         nil: :empty,
                                         empty: :empty,
                                         omitted: :empty,
                                       },
                                       to: {
                                         nil: :empty,
                                         empty: :empty,
                                         omitted: :empty,
                                       },
                                     }

          # GML Type elements
          map_element "Type", to: :gml_type,
                              value_map: {
                                from: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty,
                                },
                                to: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty,
                                },
                              }

          # GML FeatureType elements
          map_element "FeatureType", to: :gml_feature_type,
                                     value_map: {
                                       from: {
                                         nil: :empty,
                                         empty: :empty,
                                         omitted: :empty,
                                       },
                                       to: {
                                         nil: :empty,
                                         empty: :empty,
                                         omitted: :empty,
                                       },
                                     }

          # GML property elements
          map_element "property", to: :gml_property,
                                  value_map: {
                                    from: {
                                      nil: :empty,
                                      empty: :empty,
                                      omitted: :empty,
                                    },
                                    to: {
                                      nil: :empty,
                                      empty: :empty,
                                      omitted: :empty,
                                    },
                                  }
        end
      end
    end
  end
end
