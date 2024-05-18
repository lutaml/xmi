# frozen_string_literal: true

require "shale"

require_relative "classifier"

module Xmi
  module Uml13
    class Classifierrealization < Shale::Mapper
      attribute :classifier, Classifier, collection: true

      xml do
        root "Classifier.realization"
        namespace "omg.org/UML1.3", "UML"

        map_element "Classifier", to: :classifier
      end
    end
  end
end
