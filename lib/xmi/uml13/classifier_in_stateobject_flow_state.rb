require 'shale'

require_relative 'object_flow_state'

class ClassifierInStateobjectFlowState < Shale::Mapper
  attribute :object_flow_state, ObjectFlowState, collection: true

  xml do
    root 'ClassifierInState.objectFlowState'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'ObjectFlowState', to: :object_flow_state
  end
end
