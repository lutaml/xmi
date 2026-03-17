# frozen_string_literal: true

module Xmi
  module Sparx
    class Extension < Lutaml::Model::Serializable
      attribute :id, ::Xmi::Type::XmiId
      attribute :label, ::Xmi::Type::XmiLabel
      attribute :uuid, ::Xmi::Type::XmiUuid
      attribute :href, :string
      attribute :idref, ::Xmi::Type::XmiIdRef
      attribute :type, ::Xmi::Type::XmiType
      attribute :extender, :string
      attribute :extender_id, :string
      attribute :elements, Element::Elements
      attribute :connectors, Connector::Connectors
      attribute :primitive_types, PrimitiveType::PrimitiveTypes
      attribute :diagrams, Diagram::Diagrams
      attribute :ea_stub, EaStub, collection: true
      attribute :profiles, CustomProfile::Profiles

      xml do
        root "Extension"
        namespace ::Xmi::Namespace::Omg::Xmi

        map_attribute "id", to: :id
        map_attribute "label", to: :label
        map_attribute "uuid", to: :uuid
        map_attribute "href", to: :href
        map_attribute "idref", to: :idref
        map_attribute "type", to: :type
        map_attribute "extender", to: :extender
        map_attribute "extenderID", to: :extender_id

        map_element "elements", to: :elements
        map_element "connectors", to: :connectors
        map_element "primitivetypes", to: :primitive_types
        map_element "profiles", to: :profiles
        map_element "diagrams", to: :diagrams
        map_element "EAStub", to: :ea_stub, value_map: VALUE_MAP
      end
    end
  end
end
