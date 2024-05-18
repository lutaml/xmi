# frozen_string_literal: true

require "shale"

require_relative "association_end"
puts "association_end"
require_relative "association_end_role"
puts "association_end_role"

module Xmi
  module Uml13
    class Associationconnection < Shale::Mapper
      attribute :association_end, AssociationEnd, collection: true
      attribute :association_end_role, AssociationEndRole, collection: true

      xml do
        root "Association.connection"
        namespace "omg.org/UML1.3", "UML"

        map_element "AssociationEnd", to: :association_end
        map_element "AssociationEndRole", to: :association_end_role
      end
    end
  end
end
