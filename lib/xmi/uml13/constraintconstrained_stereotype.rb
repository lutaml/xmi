# frozen_string_literal: true

require "shale"

require_relative "stereotype"

class ConstraintconstrainedStereotype < Shale::Mapper
  attribute :stereotype, Stereotype, collection: true

  xml do
    root "Constraint.constrainedStereotype"
    namespace "omg.org/UML1.3", "UML"

    map_element "Stereotype", to: :stereotype
  end
end
