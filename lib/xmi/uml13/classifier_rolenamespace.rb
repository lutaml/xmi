# frozen_string_literal: true

require "shale"

require_relative "collaboration"

class ClassifierRolenamespace < Shale::Mapper
  attribute :collaboration, Collaboration, collection: true

  xml do
    root "ClassifierRole.namespace"
    namespace "omg.org/UML1.3", "UML"

    map_element "Collaboration", to: :collaboration
  end
end
