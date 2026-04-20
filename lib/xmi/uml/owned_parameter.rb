# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedParameter < Lutaml::Model::Serializable
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :type, ::Xmi::Type::XmiType
      attribute :direction, :string
      attribute :upper_value, UpperValue
      attribute :lower_value, LowerValue
      attribute :default_value, DefaultValue

      xml do
        root "ownedParameter"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_attribute "type", to: :type
        map_attribute "direction", to: :direction

        map_element "upperValue", to: :upper_value
        map_element "lowerValue", to: :lower_value
        map_element "defaultValue", to: :default_value
      end
    end
  end
end
