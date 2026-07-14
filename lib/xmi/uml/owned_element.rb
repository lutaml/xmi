# frozen_string_literal: true

module Xmi
  module Uml
    # UMLDI `<ownedElement>` — a diagram element (shape, label, etc.).
    # Carries text, optional nested ownedElement children, bounds,
    # and source/target/waypoint for connectors.
    class OwnedElement < ::Xmi::UmlDi::Base
      attribute :text, :string
      attribute :model_element, :string
      attribute :owned_element, OwnedElement, collection: true
      attribute :bounds, Bounds, collection: true
      attribute :source, :string
      attribute :target, :string
      attribute :waypoint, Waypoint, collection: true

      xml do
        root "ownedElement"
        map_attribute "text", to: :text
        map_attribute "modelElement", to: :model_element

        map_element "ownedElement", to: :owned_element, value_map: VALUE_MAP
        map_element "bounds", to: :bounds, value_map: VALUE_MAP
        map_element "source", to: :source
        map_element "target", to: :target
        map_element "waypoint", to: :waypoint, value_map: VALUE_MAP
      end
    end
  end
end
