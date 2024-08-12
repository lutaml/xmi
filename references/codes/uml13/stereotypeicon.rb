# frozen_string_literal: true

require "shale"

require_relative "geometry"

class Stereotypeicon < Shale::Mapper
  attribute :geometry, Geometry

  xml do
    root "Stereotype.icon"
    namespace "omg.org/UML1.3", "UML"

    map_element "Geometry", to: :geometry
  end
end
