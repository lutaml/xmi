# frozen_string_literal: true

require "shale"

require_relative "message"

class Interactionmessage < Shale::Mapper
  attribute :message, Message, collection: true

  xml do
    root "Interaction.message"
    namespace "omg.org/UML1.3", "UML"

    map_element "Message", to: :message
  end
end
