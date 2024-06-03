# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class AssociationRole < Shale::Mapper
    end

    class AssociationEndRoleassociationRole < Shale::Mapper
      attribute :association_role, AssociationRole, collection: true

      xml do
        root "AssociationEndRole.associationRole"
        namespace "omg.org/UML1.3", "UML"

        map_element "AssociationRole", to: :association_role
      end
    end
  end
end
