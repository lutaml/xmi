# frozen_string_literal: true

require "shale"

require_relative "event"

class StatedeferredEvent < Shale::Mapper
  attribute :event, Event, collection: true

  xml do
    root "State.deferredEvent"
    namespace "omg.org/UML1.3", "UML"

    map_element "Event", to: :event
  end
end
