# frozen_string_literal: true

require "shale"

require_relative "attribute_link"

module Xmi
  module Uml13
    class Instanceslot < Shale::Mapper
      attribute :attribute_link, AttributeLink, collection: true

      xml do
        root "Instance.slot"
        namespace "omg.org/UML1.3", "UML"

        map_element "AttributeLink", to: :attribute_link
      end
    end
  end
end
