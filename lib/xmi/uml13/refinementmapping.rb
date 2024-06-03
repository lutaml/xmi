# frozen_string_literal: true

require "shale"

require_relative "mapping"

module Xmi
  module Uml13
    class Refinementmapping < Shale::Mapper
      attribute :mapping, Mapping

      xml do
        root "Refinement.mapping"
        namespace "omg.org/UML1.3", "UML"

        map_element "Mapping", to: :mapping
      end
    end
  end
end
