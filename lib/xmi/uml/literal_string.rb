# frozen_string_literal: true

module Xmi
  module Uml
    # UML 2.5 §9.8.2.5 — a literal string value specification.
    class LiteralString < ValueSpecification
      attribute :value, :string

      xml do
        root "literalString"
        map_attribute "value", to: :value
      end
    end
  end
end
