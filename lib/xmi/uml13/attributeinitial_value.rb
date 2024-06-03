# frozen_string_literal: true

require "shale"

require_relative "boolean_expression"
require_relative "expression"
require_relative "object_set_expression"
require_relative "procedure_expression"
require_relative "time_expression"

module Xmi
  module Uml13
    class AttributeinitialValue < Shale::Mapper
      attribute :expression, Expression
      attribute :procedure_expression, ProcedureExpression
      attribute :object_set_expression, ObjectSetExpression
      attribute :time_expression, TimeExpression
      attribute :boolean_expression, BooleanExpression

      xml do
        root "Attribute.initialValue"
        namespace "omg.org/UML1.3", "UML"

        map_element "Expression", to: :expression
        map_element "ProcedureExpression", to: :procedure_expression
        map_element "ObjectSetExpression", to: :object_set_expression
        map_element "TimeExpression", to: :time_expression
        map_element "BooleanExpression", to: :boolean_expression
      end
    end
  end
end
