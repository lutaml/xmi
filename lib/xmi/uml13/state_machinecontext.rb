# frozen_string_literal: true

require "shale"

require_relative "model_element"

module Xmi
  module Uml13
    class StateMachinecontext < Shale::Mapper
      attribute :model_element, ModelElement, collection: true

      xml do
        root "StateMachine.context"
        namespace "omg.org/UML1.3", "UML"

        map_element "ModelElement", to: :model_element
      end
    end
  end
end
