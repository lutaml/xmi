# frozen_string_literal: true

require "shale"

require_relative "diagramelement"

module Xmi
  module Uml13
    class DiagramCompositions < Shale::Mapper
      attribute :diagram_element, Diagramelement, collection: true

      xml do
        root "DiagramCompositions"
        namespace "omg.org/UML1.3", "UML"

        map_element "Diagram.element", to: :diagram_element
      end
    end
  end
end
