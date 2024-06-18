# frozen_string_literal: true

require "shale"

require_relative "guard"

class Transitionguard < Shale::Mapper
  attribute :guard, Guard, collection: true

  xml do
    root "Transition.guard"
    namespace "omg.org/UML1.3", "UML"

    map_element "Guard", to: :guard
  end
end
