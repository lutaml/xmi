# frozen_string_literal: true

require "shale"

require_relative "signal_event"

class Signaloccurrence < Shale::Mapper
  attribute :signal_event, SignalEvent, collection: true

  xml do
    root "Signal.occurrence"
    namespace "omg.org/UML1.3", "UML"

    map_element "SignalEvent", to: :signal_event
  end
end
