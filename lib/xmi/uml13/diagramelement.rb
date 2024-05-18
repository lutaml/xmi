# frozen_string_literal: true

require "shale"

require_relative "diagram_element"

module Xmi
  module Uml13
    class Diagramelement < Shale::Mapper
      attribute :diagram_element, DiagramElement, collection: true

      xml do
        root "Diagram.element"
        namespace "omg.org/UML1.3", "UML"

        map_element "DiagramElement", to: :diagram_element
      end
    end
  end
end
