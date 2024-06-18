# frozen_string_literal: true

require "shale"

require_relative "classifier"

class AssociationEndspecification < Shale::Mapper
  attribute :classifier, Classifier, collection: true

  xml do
    root "AssociationEnd.specification"
    namespace "omg.org/UML1.3", "UML"

    map_element "Classifier", to: :classifier
  end
end
