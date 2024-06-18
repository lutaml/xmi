# frozen_string_literal: true

require "shale"

require_relative "instance"

class AttributeLinkinstance < Shale::Mapper
  attribute :instance, Instance, collection: true

  xml do
    root "AttributeLink.instance"
    namespace "omg.org/UML1.3", "UML"

    map_element "Instance", to: :instance
  end
end
