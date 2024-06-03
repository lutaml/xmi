# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class Attribute < Shale::Mapper
    end

    class AssociationEndqualifier < Shale::Mapper
      attribute :attribute, Attribute, collection: true

      xml do
        root "AssociationEnd.qualifier"
        namespace "omg.org/UML1.3", "UML"

        map_element "Attribute", to: :attribute
      end
    end
  end
end
