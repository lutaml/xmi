# frozen_string_literal: true

require "shale"

class PseudoStatekind < Shale::Mapper
  attribute :xmi_value, Shale::Type::String

  xml do
    root "PseudoState.kind"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "xmi.value", to: :xmi_value
  end
end
