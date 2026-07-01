# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<slot>` element — a value slot on an InstanceSpecification.
    # Carries one `<value>` child (typically an OpaqueExpression) that
    # holds the instance's value for the defining feature (the
    # attribute being instantiated).
    class Slot < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :defining_feature, :string
      attribute :value, OpaqueExpression, collection: true

      xml do
        root "slot"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "definingFeature", to: :defining_feature

        map_element "value", to: :value, value_map: VALUE_MAP
      end
    end
  end
end
