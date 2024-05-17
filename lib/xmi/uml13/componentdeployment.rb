require 'shale'

require_relative 'node'

class Componentdeployment < Shale::Mapper
  attribute :node, Node, collection: true

  xml do
    root 'Component.deployment'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Node', to: :node
  end
end
