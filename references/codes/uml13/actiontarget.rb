# frozen_string_literal: true

require "shale"

require_relative "object_set_expression"

class Actiontarget < Shale::Mapper
  attribute :object_set_expression, ObjectSetExpression

  xml do
    root "Action.target"
    namespace "omg.org/UML1.3", "UML"

    map_element "ObjectSetExpression", to: :object_set_expression
  end
end
