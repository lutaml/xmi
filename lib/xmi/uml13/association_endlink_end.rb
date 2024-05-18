# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class LinkEnd < Shale::Mapper
    end

    class AssociationEndlinkEnd < Shale::Mapper
      attribute :link_end, LinkEnd, collection: true

      xml do
        root "AssociationEnd.linkEnd"
        namespace "omg.org/UML1.3", "UML"

        map_element "LinkEnd", to: :link_end
      end
    end
  end
end
