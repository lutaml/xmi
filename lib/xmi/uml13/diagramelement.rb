# frozen_string_literal: true

require "shale"

require_relative "diagram_element"

class Diagramelement < Shale::Mapper
  attribute :diagram_element, DiagramElement, collection: true

  xml do
    root "Diagram.element"
    namespace "omg.org/UML1.3", "UML"

    map_element "DiagramElement", to: :diagram_element
  end
end
