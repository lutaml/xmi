# frozen_string_literal: true

require "shale"

require_relative "model_element"

class Partitioncontents < Shale::Mapper
  attribute :model_element, ModelElement, collection: true

  xml do
    root "Partition.contents"
    namespace "omg.org/UML1.3", "UML"

    map_element "ModelElement", to: :model_element
  end
end
