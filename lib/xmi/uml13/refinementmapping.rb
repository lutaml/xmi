# frozen_string_literal: true

require "shale"

require_relative "mapping"

class Refinementmapping < Shale::Mapper
  attribute :mapping, Mapping

  xml do
    root "Refinement.mapping"
    namespace "omg.org/UML1.3", "UML"

    map_element "Mapping", to: :mapping
  end
end
