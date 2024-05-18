# frozen_string_literal: true

require "shale"

require_relative "graphic_marker"

module Xmi
  module Uml13
    class Presentationstyle < Shale::Mapper
      attribute :graphic_marker, GraphicMarker

      xml do
        root "Presentation.style"
        namespace "omg.org/UML1.3", "UML"

        map_element "GraphicMarker", to: :graphic_marker
      end
    end
  end
end
