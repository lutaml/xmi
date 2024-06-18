# frozen_string_literal: true

require "shale"

require_relative "time_expression"

class TimeEventduration < Shale::Mapper
  attribute :time_expression, TimeExpression

  xml do
    root "TimeEvent.duration"
    namespace "omg.org/UML1.3", "UML"

    map_element "TimeExpression", to: :time_expression
  end
end
