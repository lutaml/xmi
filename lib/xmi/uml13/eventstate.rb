# frozen_string_literal: true

require "shale"

require_relative "state"

class Eventstate < Shale::Mapper
  attribute :state, State, collection: true

  xml do
    root "Event.state"
    namespace "omg.org/UML1.3", "UML"

    map_element "State", to: :state
  end
end
