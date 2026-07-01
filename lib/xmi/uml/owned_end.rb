# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedEnd < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :association, :string
      attribute :name, :string
      attribute :visibility, :string
      attribute :aggregation, :string
      attribute :uml_type, Uml::Type
      attribute :member_end, :string
      attribute :upper_value, UpperValue
      attribute :lower_value, LowerValue
      attribute :default_value, DefaultValue
      attribute :is_composite, :boolean

      xml do
        root "ownedEnd"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "visibility", to: :visibility
        map_attribute "aggregation", to: :aggregation
        map_attribute "memberEnd", to: :member_end
        map_attribute "isComposite", to: :is_composite

        map_element "type", to: :uml_type
        map_element "upperValue", to: :upper_value
        map_element "lowerValue", to: :lower_value
        map_element "defaultValue", to: :default_value
      end
    end
  end
end
