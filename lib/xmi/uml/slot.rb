# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<slot>` element — a value slot on an InstanceSpecification.
    # Carries one or more `<value>` children, each a ValueSpecification
    # (OpaqueExpression, LiteralString, etc.). The defining feature is
    # the attribute being instantiated.
    class Slot < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :defining_feature, :string
      attribute :value, ValueSpecification, collection: true, polymorphic: true

      xml do
        root "slot"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "definingFeature", to: :defining_feature

        map_element "value", to: :value,
                             polymorphic: {
                               attribute: "xmi:type",
                               class_map: {
                                 "uml:OpaqueExpression" => "Xmi::Uml::OpaqueExpression",
                                 "uml:LiteralString" => "Xmi::Uml::LiteralString",
                                 "uml:LiteralInteger" => "Xmi::Uml::LiteralInteger",
                                 "uml:LiteralBoolean" => "Xmi::Uml::LiteralBoolean",
                                 "uml:LiteralUnlimitedNatural" => "Xmi::Uml::LiteralUnlimitedNatural",
                                 "uml:LiteralNull" => "Xmi::Uml::LiteralNull",
                               },
                             }
      end
    end
  end
end
