# frozen_string_literal: true

require "shale"

require_relative "presentation"

class ModelElementpresentation < Shale::Mapper
  attribute :presentation, Presentation, collection: true

  xml do
    root "ModelElement.presentation"
    namespace "omg.org/UML1.3", "UML"

    map_element "Presentation", to: :presentation
  end
end
