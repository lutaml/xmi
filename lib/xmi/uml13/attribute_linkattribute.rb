# frozen_string_literal: true

require "shale"

require_relative "attribute"

module Xmi
  module Uml13
    class AttributeLinkattribute < Shale::Mapper
      attribute :attribute, Attribute, collection: true

      xml do
        root "AttributeLink.attribute"
        namespace "omg.org/UML1.3", "UML"

        map_element "Attribute", to: :attribute
      end
    end
  end
end
