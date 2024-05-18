# frozen_string_literal: true

require "shale"

# require_relative "association"
puts "association_rolebase: association"

module Xmi
  module Uml13
    class Association < Shale::Mapper
    end

    class AssociationRolebase < Shale::Mapper
      attribute :association, Association, collection: true

      xml do
        root "AssociationRole.base"
        namespace "omg.org/UML1.3", "UML"

        map_element "Association", to: :association
      end
    end
  end
end
