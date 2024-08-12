# frozen_string_literal: true

require "shale"

require_relative "diagramdiagram_type"
require_relative "diagramname"
require_relative "diagramstyle"
require_relative "diagramtool_name"

class DiagramProperties < Shale::Mapper
  attribute :diagram_name, Diagramname
  attribute :diagram_tool_name, DiagramtoolName
  attribute :diagram_diagram_type, DiagramdiagramType
  attribute :diagram_style, Diagramstyle

  xml do
    root "DiagramProperties"
    namespace "omg.org/UML1.3", "UML"

    map_element "Diagram.name", to: :diagram_name
    map_element "Diagram.toolName", to: :diagram_tool_name
    map_element "Diagram.diagramType", to: :diagram_diagram_type
    map_element "Diagram.style", to: :diagram_style
  end
end
