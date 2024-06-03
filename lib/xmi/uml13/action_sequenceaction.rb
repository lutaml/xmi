# frozen_string_literal: true

require "shale"

require_relative "action"
require_relative "call_action"
require_relative "create_action"
require_relative "destroy_action"
require_relative "local_invocation"
require_relative "return_action"
require_relative "send_action"
require_relative "terminate_action"
require_relative "uninterpreted_action"

module Xmi
  module Uml13
    class ActionSequenceaction < Shale::Mapper
      attribute :action, Action, collection: true
      attribute :create_action, CreateAction, collection: true
      attribute :call_action, CallAction, collection: true
      attribute :local_invocation, LocalInvocation, collection: true
      attribute :return_action, ReturnAction, collection: true
      attribute :send_action, SendAction, collection: true
      attribute :uninterpreted_action, UninterpretedAction, collection: true
      attribute :terminate_action, TerminateAction, collection: true
      attribute :destroy_action, DestroyAction, collection: true

      xml do
        root "ActionSequence.action"
        namespace "omg.org/UML1.3", "UML"

        map_element "Action", to: :action
        map_element "CreateAction", to: :create_action
        map_element "CallAction", to: :call_action
        map_element "LocalInvocation", to: :local_invocation
        map_element "ReturnAction", to: :return_action
        map_element "SendAction", to: :send_action
        map_element "UninterpretedAction", to: :uninterpreted_action
        map_element "TerminateAction", to: :terminate_action
        map_element "DestroyAction", to: :destroy_action
      end
    end
  end
end
