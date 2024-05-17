require 'shale'

require_relative 'transition'

class StateMachinetransitions < Shale::Mapper
  attribute :transition, Transition, collection: true

  xml do
    root 'StateMachine.transitions'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Transition', to: :transition
  end
end
