# frozen_string_literal: true

require "shale"

require_relative "message"

module Xmi
  module Uml13
    class ClassifierRolemessage2 < Shale::Mapper
      attribute :message, Message, collection: true

      xml do
        root "ClassifierRole.message2"
        namespace "omg.org/UML1.3", "UML"

        map_element "Message", to: :message
      end
    end
  end
end
