# frozen_string_literal: true

require "shale"

require_relative "instance"

module Xmi
  module Uml13
    class MessageInstancereceiver < Shale::Mapper
      attribute :instance, Instance, collection: true

      xml do
        root "MessageInstance.receiver"
        namespace "omg.org/UML1.3", "UML"

        map_element "Instance", to: :instance
      end
    end
  end
end
