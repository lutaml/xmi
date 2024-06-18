# frozen_string_literal: true

require "shale"

require_relative "association"

class AssociationEndassociation < Shale::Mapper
  attribute :association, Association, collection: true

  xml do
    root "AssociationEnd.association"
    namespace "omg.org/UML1.3", "UML"

    map_element "Association", to: :association
  end
end
