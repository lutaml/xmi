# frozen_string_literal: true

require "shale"

require_relative "action_sequence"

module Xmi
  module Uml13
    class Stateentry < Shale::Mapper
      attribute :action_sequence, ActionSequence, collection: true

      xml do
        root "State.entry"
        namespace "omg.org/UML1.3", "UML"

        map_element "ActionSequence", to: :action_sequence
      end
    end
  end
end
