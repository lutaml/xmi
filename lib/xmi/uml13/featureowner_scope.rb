# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class FeatureownerScope < Shale::Mapper
      attribute :xmi_value, Shale::Type::String

      xml do
        root "Feature.ownerScope"
        namespace "omg.org/UML1.3", "UML"

        map_attribute "xmi.value", to: :xmi_value
      end
    end
  end
end
