# frozen_string_literal: true

require "shale"

require_relative "action"

class Argumentaction < Shale::Mapper
  attribute :action, Action, collection: true

  xml do
    root "Argument.action"
    namespace "omg.org/UML1.3", "UML"

    map_element "Action", to: :action
  end
end
