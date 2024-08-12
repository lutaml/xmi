# frozen_string_literal: true

require "shale"

require_relative "classifier"

class Featureowner < Shale::Mapper
  attribute :classifier, Classifier, collection: true

  xml do
    root "Feature.owner"
    namespace "omg.org/UML1.3", "UML"

    map_element "Classifier", to: :classifier
  end
end
