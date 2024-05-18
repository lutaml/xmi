# frozen_string_literal: true

require "shale"

require_relative "state_vertex"

module Xmi
  module Uml13
    class Transitionsource < Shale::Mapper
      attribute :state_vertex, StateVertex, collection: true

      xml do
        root "Transition.source"
        namespace "omg.org/UML1.3", "UML"

        map_element "StateVertex", to: :state_vertex
      end
    end
  end
end
