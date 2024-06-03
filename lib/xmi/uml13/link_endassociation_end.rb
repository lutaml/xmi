# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class AssociationEnd < Shale::Mapper
    end

    class LinkEndassociationEnd < Shale::Mapper
      attribute :association_end, AssociationEnd, collection: true

      xml do
        root "LinkEnd.associationEnd"
        namespace "omg.org/UML1.3", "UML"

        map_element "AssociationEnd", to: :association_end
      end
    end
  end
end
