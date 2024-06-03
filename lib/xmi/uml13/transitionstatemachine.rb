# frozen_string_literal: true

require "shale"

require_relative "state_machine"

module Xmi
  module Uml13
    class Transitionstatemachine < Shale::Mapper
      attribute :state_machine, StateMachine, collection: true

      xml do
        root "Transition.statemachine"
        namespace "omg.org/UML1.3", "UML"

        map_element "StateMachine", to: :state_machine
      end
    end
  end
end
