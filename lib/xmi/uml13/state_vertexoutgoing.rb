require 'shale'

require_relative 'transition'

class StateVertexoutgoing < Shale::Mapper
  attribute :transition, Transition, collection: true

  xml do
    root 'StateVertex.outgoing'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Transition', to: :transition
  end
end
