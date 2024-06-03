# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class Stereotype < Shale::Mapper
    end

    class ModelElementstereotype < Shale::Mapper
      attribute :stereotype, Stereotype, collection: true

      xml do
        root "ModelElement.stereotype"
        namespace "omg.org/UML1.3", "UML"

        map_element "Stereotype", to: :stereotype
      end
    end
  end
end
