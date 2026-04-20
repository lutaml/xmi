# frozen_string_literal: true

require_relative "documentation"
require_relative "uml"

module Xmi
  class Root < Lutaml::Model::Serializable
    include XmiIdentity::Attributes

    attribute :documentation, Documentation
    attribute :bibliography, CustomProfile::Bibliography, collection: true
    attribute :basic_doc, CustomProfile::BasicDoc, collection: true
    attribute :enumeration, CustomProfile::Enumeration, collection: true
    attribute :ocl, CustomProfile::Ocl, collection: true
    attribute :invariant, CustomProfile::Invariant, collection: true
    attribute :publication_date, CustomProfile::PublicationDate,
              collection: true
    attribute :edition, CustomProfile::Edition, collection: true
    attribute :number, CustomProfile::Number, collection: true
    attribute :year_version, CustomProfile::YearVersion, collection: true
    attribute :informative, CustomProfile::Informative, collection: true
    attribute :persistence, CustomProfile::Persistence, collection: true
    attribute :abstract, CustomProfile::Abstract, collection: true

    attribute :model, Uml::UmlModel

    xml do
      root "XMI"
      namespace ::Xmi::Namespace::Omg::Xmi
      namespace_scope [
        ::Xmi::Namespace::Omg::Xmi,
        ::Xmi::Namespace::Omg::Uml,
        ::Xmi::Namespace::Omg::UmlDi,
        ::Xmi::Namespace::Omg::UmlDc,
        ::Xmi::Namespace::Sparx::Extension,
        ::Xmi::Namespace::Sparx::Gml,
        ::Xmi::Namespace::Sparx::CustomProfile,
        ::Xmi::Namespace::Sparx::SysPhS,
        ::Xmi::Namespace::Sparx::EaUml,
        ::Xmi::Namespace::Sparx::CityGml,
      ]

      XmiIdentity.apply_xml_mappings(self)

      map_element "Documentation", to: :documentation
      map_element "Model", to: :model
      map_element "Bibliography", to: :bibliography, value_map: VALUE_MAP
      map_element "BasicDoc", to: :basic_doc, value_map: VALUE_MAP
      map_element "enumeration", to: :enumeration, value_map: VALUE_MAP
      map_element "OCL", to: :ocl, value_map: VALUE_MAP
      map_element "invariant", to: :invariant, value_map: VALUE_MAP
      map_element "publicationDate", to: :publication_date, value_map: VALUE_MAP
      map_element "edition", to: :edition, value_map: VALUE_MAP
      map_element "number", to: :number, value_map: VALUE_MAP
      map_element "yearVersion", to: :year_version, value_map: VALUE_MAP
      map_element "informative", to: :informative, value_map: VALUE_MAP
      map_element "persistence", to: :persistence, value_map: VALUE_MAP
      map_element "Abstract", to: :abstract, value_map: VALUE_MAP
    end
  end
end
