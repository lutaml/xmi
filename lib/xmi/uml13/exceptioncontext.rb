# frozen_string_literal: true

require "shale"

require_relative "behavioral_feature"

class Exceptioncontext < Shale::Mapper
  attribute :behavioral_feature, BehavioralFeature, collection: true

  xml do
    root "Exception.context"
    namespace "omg.org/UML1.3", "UML"

    map_element "BehavioralFeature", to: :behavioral_feature
  end
end
