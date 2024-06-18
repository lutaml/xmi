# frozen_string_literal: true

require "shale"

require_relative "enumeration_literal"

class Enumerationliteral < Shale::Mapper
  attribute :enumeration_literal, EnumerationLiteral, collection: true

  xml do
    root "Enumeration.literal"
    namespace "omg.org/UML1.3", "UML"

    map_element "EnumerationLiteral", to: :enumeration_literal
  end
end
