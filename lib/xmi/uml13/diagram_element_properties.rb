require 'shale'

require_relative 'diagram_elementgeometry'
require_relative 'diagram_elementstyle'

class DiagramElementProperties < Shale::Mapper
  attribute :diagram_element_geometry, DiagramElementgeometry
  attribute :diagram_element_style, DiagramElementstyle

  xml do
    root 'DiagramElementProperties'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'DiagramElement.geometry', to: :diagram_element_geometry
    map_element 'DiagramElement.style', to: :diagram_element_style
  end
end
