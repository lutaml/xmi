require 'shale'

require_relative 'state'

class ActionSequencestate2 < Shale::Mapper
  attribute :state, State, collection: true

  xml do
    root 'ActionSequence.state2'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'State', to: :state
  end
end
