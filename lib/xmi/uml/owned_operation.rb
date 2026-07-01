# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedOperation < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :visibility, :string
      attribute :is_static, :string
      attribute :is_abstract, :string
      attribute :is_query, :string
      attribute :concurrency, :string
      attribute :owned_parameter, OwnedParameter, collection: true
      attribute :precondition, Precondition
      attribute :uml_type, Uml::Type, collection: true

      xml do
        root "ownedOperation"
        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_attribute "visibility", to: :visibility
        map_attribute "isStatic", to: :is_static
        map_attribute "isAbstract", to: :is_abstract
        map_attribute "isQuery", to: :is_query
        map_attribute "concurrency", to: :concurrency
        map_element "ownedParameter", to: :owned_parameter, value_map: VALUE_MAP
        map_element "precondition", to: :precondition
        map_element "type", to: :uml_type, value_map: VALUE_MAP
      end
    end
  end
end
