# frozen_string_literal: true

module Xmi
  module Sparx
    module SparxMappings
      # Base XML mapping class for Sparx EA XMI documents.
      #
      # This reusable mapping class encapsulates all the XML element → attribute
      # mappings for SparxRoot.
      #
      # @example Use in a model class
      #   class SparxRoot < Root
      #     xml SparxMappings::BaseMapping
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

          VM = ::Xmi::VALUE_MAP

          # Extension element containing Sparx EA-specific metadata
          map_element "Extension", to: :extension

          # Modelica parameter elements (SysPhS profile)
          map_element "ModelicaParameter", to: :modelica_parameter

          # UML import elements (EAUML profile)
          map_element "import", to: :eauml_import, value_map: VM

          # GML elements
          map_element "ApplicationSchema", to: :gml_application_schema,
                                           value_map: VM
          map_element "CodeList", to: :gml_code_list, value_map: VM
          map_element "DataType", to: :gml_data_type, value_map: VM
          map_element "Union", to: :gml_union, value_map: VM
          map_element "Enumeration", to: :gml_enumeration, value_map: VM
          map_element "Type", to: :gml_type, value_map: VM
          map_element "FeatureType", to: :gml_feature_type, value_map: VM
          map_element "property", to: :gml_property, value_map: VM
        end
      end
    end
  end
end
