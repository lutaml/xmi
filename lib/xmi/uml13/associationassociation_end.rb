# frozen_string_literal: true

require "shale"

require_relative "association_role"

class AssociationassociationEnd < Shale::Mapper
  attribute :association_role, AssociationRole, collection: true

  xml do
    root "Association.associationEnd"
    namespace "omg.org/UML1.3", "UML"

    map_element "AssociationRole", to: :association_role
  end
end
