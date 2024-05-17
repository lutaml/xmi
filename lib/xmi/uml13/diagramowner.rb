require 'shale'

require_relative 'abstraction'
require_relative 'action'
require_relative 'action_sequence'
require_relative 'action_state'
require_relative 'activity_model'
require_relative 'actor'
require_relative 'argument'
require_relative 'association'
require_relative 'association_class'
require_relative 'association_end'
require_relative 'association_end_role'
require_relative 'association_role'
require_relative 'attribute'
require_relative 'attribute_link'
require_relative 'behavioral_feature'
require_relative 'binding'
require_relative 'call_action'
require_relative 'call_event'
require_relative 'change_event'
require_relative 'class'
require_relative 'classifier'
require_relative 'classifier_in_state'
require_relative 'classifier_role'
require_relative 'collaboration'
require_relative 'comment'
require_relative 'component'
require_relative 'composite_state'
require_relative 'constraint'
require_relative 'create_action'
require_relative 'data_type'
require_relative 'data_value'
require_relative 'dependency'
require_relative 'destroy_action'
require_relative 'event'
require_relative 'exception'
require_relative 'feature'
require_relative 'generalizable_element'
require_relative 'generalization'
require_relative 'guard'
require_relative 'instance'
require_relative 'interaction'
require_relative 'interface'
require_relative 'link'
require_relative 'link_end'
require_relative 'link_object'
require_relative 'message'
require_relative 'method'
require_relative 'model'
require_relative 'model_element'
require_relative 'namespace'
require_relative 'node'
require_relative 'object'
require_relative 'object_flow_state'
require_relative 'operation'
require_relative 'package'
require_relative 'parameter'
require_relative 'partition'
require_relative 'reception'
require_relative 'return_action'
require_relative 'send_action'
require_relative 'signal'
require_relative 'signal_event'
require_relative 'simple_state'
require_relative 'state'
require_relative 'state_machine'
require_relative 'state_vertex'
require_relative 'stereotype'
require_relative 'structural_feature'
require_relative 'submachine_state'
require_relative 'subsystem'
require_relative 'terminate_action'
require_relative 'time_event'
require_relative 'transition'
require_relative 'uninterpreted_action'
require_relative 'usage'
require_relative 'use_case'

class Diagramowner < Shale::Mapper
  attribute :model_element, ModelElement
  attribute :namespace, Namespace
  attribute :classifier, Classifier
  attribute :class, Class
  attribute :association_class, AssociationClass
  attribute :data_type, DataType
  attribute :interface, Interface
  attribute :component, Component
  attribute :node, Node
  attribute :signal, Signal
  attribute :exception, Exception
  attribute :use_case, UseCase
  attribute :actor, Actor
  attribute :classifier_role, ClassifierRole
  attribute :classifier_in_state, ClassifierInState
  attribute :subsystem, Subsystem
  attribute :collaboration, Collaboration
  attribute :package, Package
  attribute :model, Model
  attribute :association_end, AssociationEnd
  attribute :association_end_role, AssociationEndRole
  attribute :constraint, Constraint
  attribute :generalizable_element, GeneralizableElement
  attribute :association, Association
  attribute :association_role, AssociationRole
  attribute :stereotype, Stereotype
  attribute :parameter, Parameter
  attribute :feature, Feature
  attribute :structural_feature, StructuralFeature
  attribute :attribute, Attribute
  attribute :behavioral_feature, BehavioralFeature
  attribute :operation, Operation
  attribute :method, Method
  attribute :reception, Reception
  attribute :comment, Comment
  attribute :generalization, Generalization
  attribute :dependency, Dependency
  attribute :abstraction, Abstraction
  attribute :usage, Usage
  attribute :binding, Binding
  attribute :instance, Instance
  attribute :object, Object
  attribute :link_object, LinkObject
  attribute :data_value, DataValue
  attribute :action, Action
  attribute :create_action, CreateAction
  attribute :destroy_action, DestroyAction
  attribute :uninterpreted_action, UninterpretedAction
  attribute :call_action, CallAction
  attribute :send_action, SendAction
  attribute :action_sequence, ActionSequence
  attribute :return_action, ReturnAction
  attribute :terminate_action, TerminateAction
  attribute :attribute_link, AttributeLink
  attribute :argument, Argument
  attribute :link, Link
  attribute :link_end, LinkEnd
  attribute :state_machine, StateMachine
  attribute :activity_model, ActivityModel
  attribute :event, Event
  attribute :time_event, TimeEvent
  attribute :call_event, CallEvent
  attribute :signal_event, SignalEvent
  attribute :change_event, ChangeEvent
  attribute :transition, Transition
  attribute :state_vertex, StateVertex
  attribute :state, State
  attribute :composite_state, CompositeState
  attribute :submachine_state, SubmachineState
  attribute :simple_state, SimpleState
  attribute :object_flow_state, ObjectFlowState
  attribute :action_state, ActionState
  attribute :guard, Guard
  attribute :message, Message
  attribute :interaction, Interaction
  attribute :partition, Partition

  xml do
    root 'Diagram.owner'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'ModelElement', to: :model_element
    map_element 'Namespace', to: :namespace
    map_element 'Classifier', to: :classifier
    map_element 'Class', to: :class
    map_element 'AssociationClass', to: :association_class
    map_element 'DataType', to: :data_type
    map_element 'Interface', to: :interface
    map_element 'Component', to: :component
    map_element 'Node', to: :node
    map_element 'Signal', to: :signal
    map_element 'Exception', to: :exception
    map_element 'UseCase', to: :use_case
    map_element 'Actor', to: :actor
    map_element 'ClassifierRole', to: :classifier_role
    map_element 'ClassifierInState', to: :classifier_in_state
    map_element 'Subsystem', to: :subsystem
    map_element 'Collaboration', to: :collaboration
    map_element 'Package', to: :package
    map_element 'Model', to: :model
    map_element 'AssociationEnd', to: :association_end
    map_element 'AssociationEndRole', to: :association_end_role
    map_element 'Constraint', to: :constraint
    map_element 'GeneralizableElement', to: :generalizable_element
    map_element 'Association', to: :association
    map_element 'AssociationRole', to: :association_role
    map_element 'Stereotype', to: :stereotype
    map_element 'Parameter', to: :parameter
    map_element 'Feature', to: :feature
    map_element 'StructuralFeature', to: :structural_feature
    map_element 'Attribute', to: :attribute
    map_element 'BehavioralFeature', to: :behavioral_feature
    map_element 'Operation', to: :operation
    map_element 'Method', to: :method
    map_element 'Reception', to: :reception
    map_element 'Comment', to: :comment
    map_element 'Generalization', to: :generalization
    map_element 'Dependency', to: :dependency
    map_element 'Abstraction', to: :abstraction
    map_element 'Usage', to: :usage
    map_element 'Binding', to: :binding
    map_element 'Instance', to: :instance
    map_element 'Object', to: :object
    map_element 'LinkObject', to: :link_object
    map_element 'DataValue', to: :data_value
    map_element 'Action', to: :action
    map_element 'CreateAction', to: :create_action
    map_element 'DestroyAction', to: :destroy_action
    map_element 'UninterpretedAction', to: :uninterpreted_action
    map_element 'CallAction', to: :call_action
    map_element 'SendAction', to: :send_action
    map_element 'ActionSequence', to: :action_sequence
    map_element 'ReturnAction', to: :return_action
    map_element 'TerminateAction', to: :terminate_action
    map_element 'AttributeLink', to: :attribute_link
    map_element 'Argument', to: :argument
    map_element 'Link', to: :link
    map_element 'LinkEnd', to: :link_end
    map_element 'StateMachine', to: :state_machine
    map_element 'ActivityModel', to: :activity_model
    map_element 'Event', to: :event
    map_element 'TimeEvent', to: :time_event
    map_element 'CallEvent', to: :call_event
    map_element 'SignalEvent', to: :signal_event
    map_element 'ChangeEvent', to: :change_event
    map_element 'Transition', to: :transition
    map_element 'StateVertex', to: :state_vertex
    map_element 'State', to: :state
    map_element 'CompositeState', to: :composite_state
    map_element 'SubmachineState', to: :submachine_state
    map_element 'SimpleState', to: :simple_state
    map_element 'ObjectFlowState', to: :object_flow_state
    map_element 'ActionState', to: :action_state
    map_element 'Guard', to: :guard
    map_element 'Message', to: :message
    map_element 'Interaction', to: :interaction
    map_element 'Partition', to: :partition
  end
end
