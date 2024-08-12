# frozen_string_literal: true

require "shale"

require_relative "procedure_expression"

class Methodbody < Shale::Mapper
  attribute :procedure_expression, ProcedureExpression

  xml do
    root "Method.body"
    namespace "omg.org/UML1.3", "UML"

    map_element "ProcedureExpression", to: :procedure_expression
  end
end
