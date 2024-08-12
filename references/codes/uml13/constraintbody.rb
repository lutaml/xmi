# frozen_string_literal: true

require "shale"

require_relative "boolean_expression"

class Constraintbody < Shale::Mapper
  attribute :boolean_expression, BooleanExpression

  xml do
    root "Constraint.body"
    namespace "omg.org/UML1.3", "UML"

    map_element "BooleanExpression", to: :boolean_expression
  end
end
