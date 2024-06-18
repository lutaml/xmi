# frozen_string_literal: true

require "shale"

require_relative "diagram"

class ModelElementOwnsDiagramownedDiagram < Shale::Mapper
  attribute :diagram, Diagram, collection: true

  xml do
    root "ModelElementOwnsDiagram.ownedDiagram"
    namespace "omg.org/UML1.3", "UML"

    map_element "Diagram", to: :diagram
  end
end
