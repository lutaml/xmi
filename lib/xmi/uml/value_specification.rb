# frozen_string_literal: true

module Xmi
  module Uml
    # Abstract UML ValueSpecification. UML 2.5 §9.8 — the abstract
    # parent of OpaqueExpression, LiteralString, LiteralInteger,
    # LiteralBoolean, LiteralUnlimitedNatural, LiteralNull, etc.
    #
    # Used as the type of `Slot#value` so the parser can dispatch on
    # `xmi:type` to the right concrete subclass.
    #
    # Concrete subclasses live in their own files (literal_string.rb,
    # opaque_expression.rb, etc.). Add new literals as a new file plus
    # a `polymorphic_map` entry below — OCP-friendly, no edits to Slot.
    class ValueSpecification < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :type, ::Xmi::Type::XmiType, polymorphic_class: true
      attribute :id, ::Xmi::Type::XmiId

      xml do
        root "valueSpecification"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
      end
    end
  end
end
