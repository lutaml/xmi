# frozen_string_literal: true

module Xmi
  module Uml
    # UMLDI `<waypoint>` element — a point on a connector path.
    class Waypoint < ::Xmi::UmlDi::Base
      attribute :x, :integer
      attribute :y, :integer

      xml do
        root "waypoint"
        map_attribute "x", to: :x
        map_attribute "y", to: :y
      end
    end
  end
end
