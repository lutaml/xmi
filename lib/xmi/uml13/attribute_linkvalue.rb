# frozen_string_literal: true

require "shale"

require_relative "instance"

module Xmi
  module Uml13
    class AttributeLinkvalue < Shale::Mapper
      attribute :instance, Instance, collection: true

      xml do
        root "AttributeLink.value"
        namespace "omg.org/UML1.3", "UML"

        map_element "Instance", to: :instance
      end
    end
  end
end
