# frozen_string_literal: true

require "shale"

require_relative "argument"

class ActionactualArgument < Shale::Mapper
  attribute :argument, Argument, collection: true

  xml do
    root "Action.actualArgument"
    namespace "omg.org/UML1.3", "UML"

    map_element "Argument", to: :argument
  end
end
