# frozen_string_literal: true

module Xmi
  module Uml
    # UML 2.5 §9.8.2.5 — a literal string value specification.
    class LiteralString < ValueSpecification
      skip_reference_registration
      attribute :value, :string

      xml do
        root "literalString"
        namespace ::Xmi::Namespace::Omg::Uml
        map_attribute "value", to: :value
      end
    end
  end
end
