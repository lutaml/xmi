# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class ModelElement < Shale::Mapper
    end

    class ConstraintconstrainedElement < Shale::Mapper
      attribute :model_element, ModelElement, collection: true

      xml do
        root "Constraint.constrainedElement"
        namespace "omg.org/UML1.3", "UML"

        map_element "ModelElement", to: :model_element
      end
    end
  end
end
