# frozen_string_literal: true

require "shale"

require_relative "component"

class ModelElementimplementation < Shale::Mapper
  attribute :component, Component, collection: true

  xml do
    root "ModelElement.implementation"
    namespace "omg.org/UML1.3", "UML"

    map_element "Component", to: :component
  end
end
