# frozen_string_literal: true

require "shale"

require_relative "transition"

class StateinternalTransition < Shale::Mapper
  attribute :transition, Transition, collection: true

  xml do
    root "State.internalTransition"
    namespace "omg.org/UML1.3", "UML"

    map_element "Transition", to: :transition
  end
end
