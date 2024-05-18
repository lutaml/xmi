# frozen_string_literal: true

require "shale"

require_relative "message_instance"

module Xmi
  module Uml13
    class InstancemessageInstance < Shale::Mapper
      attribute :message_instance, MessageInstance, collection: true

      xml do
        root "Instance.messageInstance"
        namespace "omg.org/UML1.3", "UML"

        map_element "MessageInstance", to: :message_instance
      end
    end
  end
end
