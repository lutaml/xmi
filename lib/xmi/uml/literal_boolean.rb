# frozen_string_literal: true

module Xmi
  module Uml
    # UML 2.5 §9.8.2.7 — a literal boolean value specification.
    class LiteralBoolean < ValueSpecification
      skip_reference_registration
      attribute :value, :boolean

      xml do
        root "literalBoolean"
        namespace ::Xmi::Namespace::Omg::Uml
        map_attribute "value", to: :value
      end
    end
  end
end
