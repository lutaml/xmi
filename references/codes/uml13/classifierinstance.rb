# frozen_string_literal: true

require "shale"

require_relative "instance"

class Classifierinstance < Shale::Mapper
  attribute :instance, Instance, collection: true

  xml do
    root "Classifier.instance"
    namespace "omg.org/UML1.3", "UML"

    map_element "Instance", to: :instance
  end
end
