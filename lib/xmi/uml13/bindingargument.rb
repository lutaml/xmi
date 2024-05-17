require 'shale'

require_relative 'action'
require_relative 'action_sequence'
require_relative 'action_state'
require_relative 'activity_model'
require_relative 'activity_state'
require_relative 'actor'
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
require_relative 'enumeration'
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
require_relative 'local_invocation'
require_relative 'message'
require_relative 'message_instance'
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
require_relative 'primitive'
require_relative 'pseudo_state'
require_relative 'reception'
require_relative 'refinement'
require_relative 'request'
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
require_relative 'structure'
require_relative 'submachine_state'
require_relative 'subsystem'
require_relative 'terminate_action'
require_relative 'time_event'
require_relative 'trace'
require_relative 'transition'
require_relative 'uninterpreted_action'
require_relative 'usage'
require_relative 'use_case'
require_relative 'use_case_instance'

class Bindingargument < Shale::Mapper
  attribute :model_element, ModelElement, collection: true
  attribute :comment, Comment, collection: true
  attribute :namespace, Namespace, collection: true
  attribute :generalizable_element, GeneralizableElement, collection: true
  attribute :feature, Feature, collection: true
  attribute :parameter, Parameter, collection: true
  attribute :constraint, Constraint, collection: true
  attribute :dependency, Dependency, collection: true
  attribute :generalization, Generalization, collection: true
  attribute :association_end, AssociationEnd, collection: true
  attribute :request, Request, collection: true
  attribute :action_sequence, ActionSequence, collection: true
  attribute :action, Action, collection: true
  attribute :link, Link, collection: true
  attribute :link_end, LinkEnd, collection: true
  attribute :instance, Instance, collection: true
  attribute :attribute_link, AttributeLink, collection: true
  attribute :message_instance, MessageInstance, collection: true
  attribute :interaction, Interaction, collection: true
  attribute :message, Message, collection: true
  attribute :state_machine, StateMachine, collection: true
  attribute :guard, Guard, collection: true
  attribute :state_vertex, StateVertex, collection: true
  attribute :transition, Transition, collection: true
  attribute :event, Event, collection: true
  attribute :partition, Partition, collection: true
  attribute :collaboration, Collaboration, collection: true
  attribute :classifier, Classifier, collection: true
  attribute :association, Association, collection: true
  attribute :stereotype, Stereotype, collection: true
  attribute :package, Package, collection: true
  attribute :signal, Signal, collection: true
  attribute :node, Node, collection: true
  attribute :component, Component, collection: true
  attribute :interface, Interface, collection: true
  attribute :class, Class, collection: true
  attribute :data_type, DataType, collection: true
  attribute :subsystem, Subsystem, collection: true
  attribute :classifier_role, ClassifierRole, collection: true
  attribute :actor, Actor, collection: true
  attribute :use_case, UseCase, collection: true
  attribute :classifier_in_state, ClassifierInState, collection: true
  attribute :association_class, AssociationClass, collection: true
  attribute :enumeration, Enumeration, collection: true
  attribute :primitive, Primitive, collection: true
  attribute :structure, Structure, collection: true
  attribute :association_role, AssociationRole, collection: true
  attribute :model, Model, collection: true
  attribute :exception, Exception, collection: true
  attribute :structural_feature, StructuralFeature, collection: true
  attribute :behavioral_feature, BehavioralFeature, collection: true
  attribute :attribute, Attribute, collection: true
  attribute :operation, Operation, collection: true
  attribute :method, Method, collection: true
  attribute :reception, Reception, collection: true
  attribute :refinement, Refinement, collection: true
  attribute :usage, Usage, collection: true
  attribute :trace, Trace, collection: true
  attribute :binding, Binding, collection: true
  attribute :association_end_role, AssociationEndRole, collection: true
  attribute :create_action, CreateAction, collection: true
  attribute :call_action, CallAction, collection: true
  attribute :local_invocation, LocalInvocation, collection: true
  attribute :return_action, ReturnAction, collection: true
  attribute :send_action, SendAction, collection: true
  attribute :uninterpreted_action, UninterpretedAction, collection: true
  attribute :terminate_action, TerminateAction, collection: true
  attribute :destroy_action, DestroyAction, collection: true
  attribute :link_object, LinkObject, collection: true
  attribute :object, Object, collection: true
  attribute :data_value, DataValue, collection: true
  attribute :use_case_instance, UseCaseInstance, collection: true
  attribute :activity_model, ActivityModel, collection: true
  attribute :pseudo_state, PseudoState, collection: true
  attribute :state, State, collection: true
  attribute :composite_state, CompositeState, collection: true
  attribute :simple_state, SimpleState, collection: true
  attribute :submachine_state, SubmachineState, collection: true
  attribute :action_state, ActionState, collection: true
  attribute :object_flow_state, ObjectFlowState, collection: true
  attribute :activity_state, ActivityState, collection: true
  attribute :signal_event, SignalEvent, collection: true
  attribute :call_event, CallEvent, collection: true
  attribute :time_event, TimeEvent, collection: true
  attribute :change_event, ChangeEvent, collection: true

  xml do
    root 'Binding.argument'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'ModelElement', to: :model_element
    map_element 'Comment', to: :comment
    map_element 'Namespace', to: :namespace
    map_element 'GeneralizableElement', to: :generalizable_element
    map_element 'Feature', to: :feature
    map_element 'Parameter', to: :parameter
    map_element 'Constraint', to: :constraint
    map_element 'Dependency', to: :dependency
    map_element 'Generalization', to: :generalization
    map_element 'AssociationEnd', to: :association_end
    map_element 'Request', to: :request
    map_element 'ActionSequence', to: :action_sequence
    map_element 'Action', to: :action
    map_element 'Link', to: :link
    map_element 'LinkEnd', to: :link_end
    map_element 'Instance', to: :instance
    map_element 'AttributeLink', to: :attribute_link
    map_element 'MessageInstance', to: :message_instance
    map_element 'Interaction', to: :interaction
    map_element 'Message', to: :message
    map_element 'StateMachine', to: :state_machine
    map_element 'Guard', to: :guard
    map_element 'StateVertex', to: :state_vertex
    map_element 'Transition', to: :transition
    map_element 'Event', to: :event
    map_element 'Partition', to: :partition
    map_element 'Collaboration', to: :collaboration
    map_element 'Classifier', to: :classifier
    map_element 'Association', to: :association
    map_element 'Stereotype', to: :stereotype
    map_element 'Package', to: :package
    map_element 'Signal', to: :signal
    map_element 'Node', to: :node
    map_element 'Component', to: :component
    map_element 'Interface', to: :interface
    map_element 'Class', to: :class
    map_element 'DataType', to: :data_type
    map_element 'Subsystem', to: :subsystem
    map_element 'ClassifierRole', to: :classifier_role
    map_element 'Actor', to: :actor
    map_element 'UseCase', to: :use_case
    map_element 'ClassifierInState', to: :classifier_in_state
    map_element 'AssociationClass', to: :association_class
    map_element 'Enumeration', to: :enumeration
    map_element 'Primitive', to: :primitive
    map_element 'Structure', to: :structure
    map_element 'AssociationRole', to: :association_role
    map_element 'Model', to: :model
    map_element 'Exception', to: :exception
    map_element 'StructuralFeature', to: :structural_feature
    map_element 'BehavioralFeature', to: :behavioral_feature
    map_element 'Attribute', to: :attribute
    map_element 'Operation', to: :operation
    map_element 'Method', to: :method
    map_element 'Reception', to: :reception
    map_element 'Refinement', to: :refinement
    map_element 'Usage', to: :usage
    map_element 'Trace', to: :trace
    map_element 'Binding', to: :binding
    map_element 'AssociationEndRole', to: :association_end_role
    map_element 'CreateAction', to: :create_action
    map_element 'CallAction', to: :call_action
    map_element 'LocalInvocation', to: :local_invocation
    map_element 'ReturnAction', to: :return_action
    map_element 'SendAction', to: :send_action
    map_element 'UninterpretedAction', to: :uninterpreted_action
    map_element 'TerminateAction', to: :terminate_action
    map_element 'DestroyAction', to: :destroy_action
    map_element 'LinkObject', to: :link_object
    map_element 'Object', to: :object
    map_element 'DataValue', to: :data_value
    map_element 'UseCaseInstance', to: :use_case_instance
    map_element 'ActivityModel', to: :activity_model
    map_element 'PseudoState', to: :pseudo_state
    map_element 'State', to: :state
    map_element 'CompositeState', to: :composite_state
    map_element 'SimpleState', to: :simple_state
    map_element 'SubmachineState', to: :submachine_state
    map_element 'ActionState', to: :action_state
    map_element 'ObjectFlowState', to: :object_flow_state
    map_element 'ActivityState', to: :activity_state
    map_element 'SignalEvent', to: :signal_event
    map_element 'CallEvent', to: :call_event
    map_element 'TimeEvent', to: :time_event
    map_element 'ChangeEvent', to: :change_event
  end
end
