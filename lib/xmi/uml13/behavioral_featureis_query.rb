# frozen_string_literal: true

require "shale"

class BehavioralFeatureisQuery < Shale::Mapper
  attribute :xmi_value, Shale::Type::String

  xml do
    root "BehavioralFeature.isQuery"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "xmi.value", to: :xmi_value
  end
end
