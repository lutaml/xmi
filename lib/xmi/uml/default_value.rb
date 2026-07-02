# frozen_string_literal: true

require_relative "value_specification"

module Xmi
  module Uml
    # Default value wrapper. Semantically a ValueSpecification
    # (UML 2.5 §9.8) — kept as a concrete subclass for backwards
    # compatibility with code that constructs DefaultValue directly
    # (e.g. the lutaml/ea transformer).
    class DefaultValue < ValueSpecification
      attribute :value, :string

      xml do
        root "defaultValue"
        map_attribute "value", to: :value
      end
    end
  end
end
