# frozen_string_literal: true

require "shale"

require_relative "action"
require_relative "action_sequence"
require_relative "argument"
require_relative "attribute_link"
require_relative "call_action"
require_relative "create_action"
require_relative "data_value"
require_relative "destroy_action"
require_relative "exception"
require_relative "instance"
require_relative "link"
require_relative "link_end"
require_relative "link_object"
require_relative "local_invocation"
require_relative "message_instance"
require_relative "object"
require_relative "reception"
require_relative "request"
require_relative "return_action"
require_relative "send_action"
require_relative "signal"
require_relative "terminate_action"
require_relative "uninterpreted_action"

class CommonBehavior < Shale::Mapper
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :request, Request, collection: true
  attribute :signal, Signal, collection: true
  attribute :exception, Exception, collection: true
  attribute :reception, Reception, collection: true
  attribute :argument, Argument, collection: true
  attribute :action_sequence, ActionSequence, collection: true
  attribute :action, Action, collection: true
  attribute :create_action, CreateAction, collection: true
  attribute :call_action, CallAction, collection: true
  attribute :local_invocation, LocalInvocation, collection: true
  attribute :return_action, ReturnAction, collection: true
  attribute :send_action, SendAction, collection: true
  attribute :uninterpreted_action, UninterpretedAction, collection: true
  attribute :terminate_action, TerminateAction, collection: true
  attribute :destroy_action, DestroyAction, collection: true
  attribute :link, Link, collection: true
  attribute :link_end, LinkEnd, collection: true
  attribute :instance, Instance, collection: true
  attribute :attribute_link, AttributeLink, collection: true
  attribute :object, Object, collection: true
  attribute :data_value, DataValue, collection: true
  attribute :link_object, LinkObject, collection: true
  attribute :message_instance, MessageInstance, collection: true

  xml do
    root "Common_Behavior"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "xmi.id", to: :xmi_id
    map_attribute "xmi.label", to: :xmi_label
    map_attribute "xmi.uuid", to: :xmi_uuid
    map_attribute "href", to: :href
    map_attribute "xmi.idref", to: :xmi_idref
    map_element "Request", to: :request
    map_element "Signal", to: :signal
    map_element "Exception", to: :exception
    map_element "Reception", to: :reception
    map_element "Argument", to: :argument
    map_element "ActionSequence", to: :action_sequence
    map_element "Action", to: :action
    map_element "CreateAction", to: :create_action
    map_element "CallAction", to: :call_action
    map_element "LocalInvocation", to: :local_invocation
    map_element "ReturnAction", to: :return_action
    map_element "SendAction", to: :send_action
    map_element "UninterpretedAction", to: :uninterpreted_action
    map_element "TerminateAction", to: :terminate_action
    map_element "DestroyAction", to: :destroy_action
    map_element "Link", to: :link
    map_element "LinkEnd", to: :link_end
    map_element "Instance", to: :instance
    map_element "AttributeLink", to: :attribute_link
    map_element "Object", to: :object
    map_element "DataValue", to: :data_value
    map_element "LinkObject", to: :link_object
    map_element "MessageInstance", to: :message_instance
  end
end
