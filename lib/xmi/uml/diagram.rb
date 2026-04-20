# frozen_string_literal: true

module Xmi
  module Uml
    class Diagram < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :is_frame, :boolean
      attribute :model_element, :string
      attribute :owned_element, OwnedElement, collection: true

      xml do
        root "Diagram"
        namespace ::Xmi::Namespace::Omg::UmlDi

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "isFrame", to: :is_frame
        map_attribute "modelElement", to: :model_element

        map_element "ownedElement", to: :owned_element, value_map: VALUE_MAP
      end
    end
  end
end
