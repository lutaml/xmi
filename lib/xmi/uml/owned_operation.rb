# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedOperation < Lutaml::Model::Serializable
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :owned_parameter, OwnedParameter, collection: true
      attribute :precondition, Precondition
      attribute :uml_type, Uml::Type, collection: true

      xml do
        root "ownedOperation"
        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_element "ownedParameter", to: :owned_parameter, value_map: VALUE_MAP
        map_element "precondition", to: :precondition
        map_element "type", to: :uml_type, value_map: VALUE_MAP
      end
    end
  end
end
