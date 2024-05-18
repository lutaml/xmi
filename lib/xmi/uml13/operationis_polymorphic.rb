# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class OperationisPolymorphic < Shale::Mapper
      attribute :xmi_value, Shale::Type::String

      xml do
        root "Operation.isPolymorphic"
        namespace "omg.org/UML1.3", "UML"

        map_attribute "xmi.value", to: :xmi_value
      end
    end
  end
end
