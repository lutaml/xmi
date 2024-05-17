require 'shale'

require_relative 'state'

class Transitionstate < Shale::Mapper
  attribute :state, State, collection: true

  xml do
    root 'Transition.state'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'State', to: :state
  end
end
