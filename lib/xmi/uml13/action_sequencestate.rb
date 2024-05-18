# frozen_string_literal: true

require "shale"

require_relative "state"

module Xmi
  module Uml13
    class ActionSequencestate < Shale::Mapper
      attribute :state, State, collection: true

      xml do
        root "ActionSequence.state"
        namespace "omg.org/UML1.3", "UML"

        map_element "State", to: :state
      end
    end
  end
end
