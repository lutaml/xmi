require 'shale'

require_relative 'submachine_state'

class StateMachinesubmachineState < Shale::Mapper
  attribute :submachine_state, SubmachineState, collection: true

  xml do
    root 'StateMachine.submachineState'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'SubmachineState', to: :submachine_state
  end
end
