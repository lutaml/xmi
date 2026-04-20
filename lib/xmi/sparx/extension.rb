# frozen_string_literal: true

module Xmi
  module Sparx
    class Extension < Lutaml::Model::Serializable
      include XmiIdentity::Attributes

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

        XmiIdentity.apply_xml_mappings(self)

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
