# frozen_string_literal: true

module Xmi
  module Uml
    # UML 2.5 §9.8.2.7 — a literal boolean value specification.
    class LiteralBoolean < ValueSpecification
      attribute :value, :boolean

      xml do
        root "literalBoolean"
        map_attribute "value", to: :value
      end
    end
  end
end
