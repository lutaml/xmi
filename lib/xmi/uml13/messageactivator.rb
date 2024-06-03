# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class Message < Shale::Mapper
    end

    class Messageactivator < Shale::Mapper
      attribute :message, Message, collection: true

      xml do
        root "Message.activator"
        namespace "omg.org/UML1.3", "UML"

        map_element "Message", to: :message
      end
    end
  end
end
