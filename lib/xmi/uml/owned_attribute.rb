# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedAttribute < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :association, :string
      attribute :name, :string
      attribute :visibility, :string
      attribute :is_derived, :boolean
      attribute :is_id, :boolean
      attribute :is_ordered, :boolean
      attribute :is_unique, :boolean
      attribute :is_read_only, :boolean
      # `default` is the XMI attribute form (string shortcut);
      # `default_value` below is the child <defaultValue> element
      # (ValueSpecification). UML 2.5 Property carries both shapes.
      attribute :default, :string
      attribute :aggregation, :string
      attribute :uml_type, Uml::Type
      attribute :upper_value, UpperValue
      attribute :lower_value, LowerValue
      attribute :default_value, DefaultValue

      xml do
        root "ownedAttribute"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "visibility", to: :visibility
        map_attribute "isDerived", to: :is_derived
        map_attribute "isID", to: :is_id
        map_attribute "isOrdered", to: :is_ordered
        map_attribute "isUnique", to: :is_unique
        map_attribute "isReadOnly", to: :is_read_only
        map_attribute "default", to: :default
        map_attribute "aggregation", to: :aggregation

        map_element "type", to: :uml_type
        map_element "upperValue", to: :upper_value
        map_element "lowerValue", to: :lower_value
        map_element "defaultValue", to: :default_value
      end
    end
  end
end
