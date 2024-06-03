# frozen_string_literal: true

require "shale"

require_relative "call_event"

module Xmi
  module Uml13
    class Operationoccurrence < Shale::Mapper
      attribute :call_event, CallEvent, collection: true

      xml do
        root "Operation.occurrence"
        namespace "omg.org/UML1.3", "UML"

        map_element "CallEvent", to: :call_event
      end
    end
  end
end
