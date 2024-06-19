# frozen_string_literal: true

require "shale"

require_relative "association_end_role"

class AssociationEndassociationEndRole < Shale::Mapper
  attribute :association_end_role, AssociationEndRole, collection: true

  xml do
    root "AssociationEnd.associationEndRole"
    namespace "omg.org/UML1.3", "UML"

    map_element "AssociationEndRole", to: :association_end_role
  end
end
