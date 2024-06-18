# frozen_string_literal: true

require "shale"

require_relative "state_vertex"

class Transitiontarget < Shale::Mapper
  attribute :state_vertex, StateVertex, collection: true

  xml do
    root "Transition.target"
    namespace "omg.org/UML1.3", "UML"

    map_element "StateVertex", to: :state_vertex
  end
end
