# frozen_string_literal: true

require "shale"

require_relative "partition"

class ModelElementpartition < Shale::Mapper
  attribute :partition, Partition, collection: true

  xml do
    root "ModelElement.partition"
    namespace "omg.org/UML1.3", "UML"

    map_element "Partition", to: :partition
  end
end
