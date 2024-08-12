# frozen_string_literal: true

require "shale"

require_relative "signal"

class SignalEventsignal < Shale::Mapper
  attribute :signal, Signal, collection: true

  xml do
    root "SignalEvent.signal"
    namespace "omg.org/UML1.3", "UML"

    map_element "Signal", to: :signal
  end
end
