# frozen_string_literal: true

require "shale"

require_relative "transition"

module Xmi
  module Uml13
    class Guardtransition < Shale::Mapper
      attribute :transition, Transition, collection: true

      xml do
        root "Guard.transition"
        namespace "omg.org/UML1.3", "UML"

        map_element "Transition", to: :transition
      end
    end
  end
end
