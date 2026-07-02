# frozen_string_literal: true

require_relative "default_value"

module Xmi
  module Uml
    class LowerValue < DefaultValue
      xml do
        root "lowerValue"
      end
    end
  end
end
