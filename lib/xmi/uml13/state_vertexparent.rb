# frozen_string_literal: true

require "shale"

require_relative "composite_state"

module Xmi
  module Uml13
    class StateVertexparent < Shale::Mapper
      attribute :composite_state, CompositeState, collection: true

      xml do
        root "StateVertex.parent"
        namespace "omg.org/UML1.3", "UML"

        map_element "CompositeState", to: :composite_state
      end
    end
  end
end
