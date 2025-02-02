# frozen_string_literal: true

require "shale"

require_relative "model_element"

class Componentimplements < Shale::Mapper
  attribute :model_element, ModelElement, collection: true

  xml do
    root "Component.implements"
    namespace "omg.org/UML1.3", "UML"

    map_element "ModelElement", to: :model_element
  end
end
