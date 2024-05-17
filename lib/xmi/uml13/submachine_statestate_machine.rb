require 'shale'

require_relative 'state_machine'

class SubmachineStatestateMachine < Shale::Mapper
  attribute :state_machine, StateMachine, collection: true

  xml do
    root 'SubmachineState.stateMachine'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'StateMachine', to: :state_machine
  end
end
