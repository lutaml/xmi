# frozen_string_literal: true

require "shale"

require_relative "view_element"

module Xmi
  module Uml13
    class ModelElementview < Shale::Mapper
      attribute :view_element, ViewElement, collection: true

      xml do
        root "ModelElement.view"
        namespace "omg.org/UML1.3", "UML"

        map_element "ViewElement", to: :view_element
      end
    end
  end
end
