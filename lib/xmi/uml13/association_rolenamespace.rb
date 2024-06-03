# frozen_string_literal: true

require "shale"

require_relative "collaboration"

module Xmi
  module Uml13
    class AssociationRolenamespace < Shale::Mapper
      attribute :collaboration, Collaboration, collection: true

      xml do
        root "AssociationRole.namespace"
        namespace "omg.org/UML1.3", "UML"

        map_element "Collaboration", to: :collaboration
      end
    end
  end
end
