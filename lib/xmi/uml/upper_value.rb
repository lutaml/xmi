# frozen_string_literal: true

require_relative "default_value"

module Xmi
  module Uml
    class UpperValue < DefaultValue
      xml do
        root "upperValue"
      end
    end
  end
end
