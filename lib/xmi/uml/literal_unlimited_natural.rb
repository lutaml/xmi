# frozen_string_literal: true

module Xmi
  module Uml
    # UML 2.5 §9.8.2.8 — a literal unlimited-natural value
    # specification. `value` is "*" for unbounded.
    class LiteralUnlimitedNatural < ValueSpecification
      attribute :value, :string

      xml do
        root "literalUnlimitedNatural"
        map_attribute "value", to: :value
      end
    end
  end
end
