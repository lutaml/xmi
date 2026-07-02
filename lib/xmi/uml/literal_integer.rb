# frozen_string_literal: true

module Xmi
  module Uml
    # UML 2.5 §9.8.2.6 — a literal integer value specification.
    class LiteralInteger < ValueSpecification
      skip_reference_registration
      attribute :value, :integer

      xml do
        root "literalInteger"
        namespace ::Xmi::Namespace::Omg::Uml
        map_attribute "value", to: :value
      end
    end
  end
end
