# frozen_string_literal: true

module Xmi
  module Uml
    # UML 2.5 §9.8.2.4 — a literal null value specification. Carries
    # no `value` attribute; presence of a LiteralNull child indicates
    # the slot is explicitly null (vs. absent).
    class LiteralNull < ValueSpecification
      xml do
        root "literalNull"
      end
    end
  end
end
