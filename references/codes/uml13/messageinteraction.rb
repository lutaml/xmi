# frozen_string_literal: true

require "shale"

require_relative "interaction"

class Messageinteraction < Shale::Mapper
  attribute :interaction, Interaction, collection: true

  xml do
    root "Message.interaction"
    namespace "omg.org/UML1.3", "UML"

    map_element "Interaction", to: :interaction
  end
end
