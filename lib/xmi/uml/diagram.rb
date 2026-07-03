# frozen_string_literal: true

require_relative "../uml_di/base"
require_relative "owned_element"

module Xmi
  module Uml
    # UMLDI `<Diagram>` element — root of a diagram's interchange view.
    class Diagram < ::Xmi::UmlDi::Base
      attribute :is_frame, :boolean
      attribute :model_element, :string
      attribute :owned_element, OwnedElement, collection: true

      xml do
        root "Diagram"
        map_attribute "isFrame", to: :is_frame
        map_attribute "modelElement", to: :model_element

        map_element "ownedElement", to: :owned_element, value_map: VALUE_MAP
      end
    end
  end
end
