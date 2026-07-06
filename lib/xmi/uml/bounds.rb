# frozen_string_literal: true

module Xmi
  module Uml
    # UMLDI `<bounds>` element — a rectangle in diagram coordinates.
    class Bounds < ::Xmi::UmlDi::Base
      attribute :x, :integer
      attribute :y, :integer
      attribute :height, :integer
      attribute :width, :integer

      xml do
        root "bounds"
        map_attribute "x", to: :x
        map_attribute "y", to: :y
        map_attribute "height", to: :height
        map_attribute "width", to: :width
      end
    end
  end
end
