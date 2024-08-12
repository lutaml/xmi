# frozen_string_literal: true

require "shale"

require_relative "constraint"

class ModelElementconstraint < Shale::Mapper
  attribute :constraint, Constraint, collection: true

  xml do
    root "ModelElement.constraint"
    namespace "omg.org/UML1.3", "UML"

    map_element "Constraint", to: :constraint
  end
end
