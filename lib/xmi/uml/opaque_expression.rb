# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<opaqueExpression>` element — used as the body of a Slot's
    # `<value>` element and as the language-bodied body of behavioral
    # features. Sparx EA serialises instance-specification values as
    # OpaqueExpression with a `body` attribute carrying the literal
    # expression text.
    #
    # Per UML 2.5 §8.3, `body` and `language` are parallel arrays
    # (`String [*]`): `body[i]` is written in `language[i]`. Most
    # Sparx output carries a single pair; we model the collection
    # form so multi-language expressions round-trip without loss.
    class OpaqueExpression < ValueSpecification
      attribute :body, :string, collection: true
      attribute :language, :string, collection: true
      attribute :body_attribute, :string
      attribute :language_attribute, :string

      xml do
        root "opaqueExpression"
        map_attribute "body", to: :body_attribute
        map_attribute "language", to: :language_attribute

        map_element "body", to: :body
        map_element "language", to: :language
      end
    end
  end
end
