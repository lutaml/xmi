# frozen_string_literal: true

require "shale"

require_relative "parameter"

class Classifierparameter < Shale::Mapper
  attribute :parameter, Parameter, collection: true

  xml do
    root "Classifier.parameter"
    namespace "omg.org/UML1.3", "UML"

    map_element "Parameter", to: :parameter
  end
end
