# frozen_string_literal: true

require "shale"

require_relative "action_state"
require_relative "activity_model"
require_relative "activity_state"
require_relative "call_event"
require_relative "change_event"
require_relative "classifier_in_state"
require_relative "composite_state"
require_relative "event"
require_relative "guard"
require_relative "object_flow_state"
require_relative "partition"
require_relative "pseudo_state"
require_relative "signal_event"
require_relative "simple_state"
require_relative "state"
require_relative "state_machine"
require_relative "state_vertex"
require_relative "submachine_state"
require_relative "time_event"
require_relative "transition"

module Xmi
  module Uml13
    class StateMachines < Shale::Mapper
      attribute :xmi_id, Shale::Type::Value
      attribute :xmi_label, Shale::Type::Value
      attribute :xmi_uuid, Shale::Type::Value
      attribute :href, Shale::Type::Value
      attribute :xmi_idref, Shale::Type::Value
      attribute :state_machine, StateMachine, collection: true
      attribute :guard, Guard, collection: true
      attribute :state_vertex, StateVertex, collection: true
      attribute :transition, Transition, collection: true
      attribute :pseudo_state, PseudoState, collection: true
      attribute :state, State, collection: true
      attribute :composite_state, CompositeState, collection: true
      attribute :simple_state, SimpleState, collection: true
      attribute :submachine_state, SubmachineState, collection: true
      attribute :event, Event, collection: true
      attribute :signal_event, SignalEvent, collection: true
      attribute :call_event, CallEvent, collection: true
      attribute :time_event, TimeEvent, collection: true
      attribute :change_event, ChangeEvent, collection: true
      attribute :activity_model, ActivityModel, collection: true
      attribute :partition, Partition, collection: true
      attribute :action_state, ActionState, collection: true
      attribute :object_flow_state, ObjectFlowState, collection: true
      attribute :classifier_in_state, ClassifierInState, collection: true
      attribute :activity_state, ActivityState, collection: true

      xml do
        root "State_Machines"
        namespace "omg.org/UML1.3", "UML"

        map_attribute "xmi.id", to: :xmi_id
        map_attribute "xmi.label", to: :xmi_label
        map_attribute "xmi.uuid", to: :xmi_uuid
        map_attribute "href", to: :href
        map_attribute "xmi.idref", to: :xmi_idref
        map_element "StateMachine", to: :state_machine
        map_element "Guard", to: :guard
        map_element "StateVertex", to: :state_vertex
        map_element "Transition", to: :transition
        map_element "PseudoState", to: :pseudo_state
        map_element "State", to: :state
        map_element "CompositeState", to: :composite_state
        map_element "SimpleState", to: :simple_state
        map_element "SubmachineState", to: :submachine_state
        map_element "Event", to: :event
        map_element "SignalEvent", to: :signal_event
        map_element "CallEvent", to: :call_event
        map_element "TimeEvent", to: :time_event
        map_element "ChangeEvent", to: :change_event
        map_element "ActivityModel", to: :activity_model
        map_element "Partition", to: :partition
        map_element "ActionState", to: :action_state
        map_element "ObjectFlowState", to: :object_flow_state
        map_element "ClassifierInState", to: :classifier_in_state
        map_element "ActivityState", to: :activity_state
      end
    end
  end
end
