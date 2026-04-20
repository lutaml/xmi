# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedAttribute < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :association, :string
      attribute :name, :string
      attribute :is_derived, :string
      attribute :uml_type, Uml::Type
      attribute :upper_value, UpperValue
      attribute :lower_value, LowerValue

      xml do
        root "ownedAttribute"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "isDerived", to: :is_derived

        map_element "type", to: :uml_type
        map_element "upperValue", to: :upper_value
        map_element "lowerValue", to: :lower_value
      end
    end
  end
end
