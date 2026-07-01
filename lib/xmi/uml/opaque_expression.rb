# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<opaqueExpression>` element — used as the body of a Slot's
    # `<value>` element and as the language-bodied body of behavioral
    # features. Sparx EA serialises instance-specification values as
    # OpaqueExpression with a `body` attribute carrying the literal
    # expression text.
    class OpaqueExpression < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :body, :string
      attribute :language, :string
      attribute :body_attribute, :string

      xml do
        root "opaqueExpression"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "body", to: :body_attribute
        map_attribute "language", to: :language

        map_element "body", to: :body
      end
    end
  end
end
