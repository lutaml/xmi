# frozen_string_literal: true

require "shale"

require_relative "event"

class Transitiontrigger < Shale::Mapper
  attribute :event, Event, collection: true

  xml do
    root "Transition.trigger"
    namespace "omg.org/UML1.3", "UML"

    map_element "Event", to: :event
  end
end
