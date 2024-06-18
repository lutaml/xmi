# frozen_string_literal: true

require "shale"

require_relative "diagram"

class DiagramElementdiagram < Shale::Mapper
  attribute :diagram, Diagram

  xml do
    root "DiagramElement.diagram"
    namespace "omg.org/UML1.3", "UML"

    map_element "Diagram", to: :diagram
  end
end
