# frozen_string_literal: true

require "shale"

require_relative "parameter"

class BehavioralFeatureparameter < Shale::Mapper
  attribute :parameter, Parameter, collection: true

  xml do
    root "BehavioralFeature.parameter"
    namespace "omg.org/UML1.3", "UML"

    map_element "Parameter", to: :parameter
  end
end
