# frozen_string_literal: true

require "shale"

require_relative "action_state"
require_relative "activity_state"
require_relative "composite_state"
require_relative "object_flow_state"
require_relative "pseudo_state"
require_relative "simple_state"
require_relative "state"
require_relative "state_vertex"
require_relative "submachine_state"

class CompositeStatesubstate < Shale::Mapper
  attribute :state_vertex, StateVertex, collection: true
  attribute :pseudo_state, PseudoState, collection: true
  attribute :state, State, collection: true
  attribute :composite_state, CompositeState, collection: true
  attribute :simple_state, SimpleState, collection: true
  attribute :submachine_state, SubmachineState, collection: true
  attribute :action_state, ActionState, collection: true
  attribute :object_flow_state, ObjectFlowState, collection: true
  attribute :activity_state, ActivityState, collection: true

  xml do
    root "CompositeState.substate"
    namespace "omg.org/UML1.3", "UML"

    map_element "StateVertex", to: :state_vertex
    map_element "PseudoState", to: :pseudo_state
    map_element "State", to: :state
    map_element "CompositeState", to: :composite_state
    map_element "SimpleState", to: :simple_state
    map_element "SubmachineState", to: :submachine_state
    map_element "ActionState", to: :action_state
    map_element "ObjectFlowState", to: :object_flow_state
    map_element "ActivityState", to: :activity_state
  end
end
