# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class AssociationEndRole < Shale::Mapper
    end

    class AssociationEndassociationEndRole < Shale::Mapper
      attribute :association_end_role, AssociationEndRole, collection: true

      xml do
        root "AssociationEnd.associationEndRole"
        namespace "omg.org/UML1.3", "UML"

        map_element "AssociationEndRole", to: :association_end_role
      end
    end
  end
end
