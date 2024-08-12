# frozen_string_literal: true

require "shale"

require_relative "feature"

class ClassifierRoleavailableFeature < Shale::Mapper
  attribute :feature, Feature, collection: true

  xml do
    root "ClassifierRole.availableFeature"
    namespace "omg.org/UML1.3", "UML"

    map_element "Feature", to: :feature
  end
end
