# frozen_string_literal: true

require "shale"

require_relative "constraint"

module Xmi
  module Uml13
    class ModelElementconstraint < Shale::Mapper
      attribute :constraint, Constraint, collection: true

      xml do
        root "ModelElement.constraint"
        namespace "omg.org/UML1.3", "UML"

        map_element "Constraint", to: :constraint
      end
    end
  end
end
