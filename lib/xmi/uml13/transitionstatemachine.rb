require 'shale'

require_relative 'state_machine'

class Transitionstatemachine < Shale::Mapper
  attribute :state_machine, StateMachine, collection: true

  xml do
    root 'Transition.statemachine'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'StateMachine', to: :state_machine
  end
end
