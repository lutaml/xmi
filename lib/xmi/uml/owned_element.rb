# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedElement < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :text, :string
      attribute :model_element, :string
      attribute :owned_element, OwnedElement, collection: true
      attribute :bounds, Bounds, collection: true
      attribute :source, :string
      attribute :target, :string
      attribute :waypoint, Waypoint

      xml do
        root "ownedElement"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "text", to: :text
        map_attribute "modelElement", to: :model_element

        map_element "ownedElement", to: :owned_element, value_map: VALUE_MAP
        map_element "bounds", to: :bounds, value_map: VALUE_MAP
        map_element "source", to: :source
        map_element "target", to: :target
        map_element "waypoint", to: :waypoint
      end
    end
  end
end
