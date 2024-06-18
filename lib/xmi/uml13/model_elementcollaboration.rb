# frozen_string_literal: true

require "shale"

require_relative "collaboration"

class ModelElementcollaboration < Shale::Mapper
  attribute :collaboration, Collaboration, collection: true

  xml do
    root "ModelElement.collaboration"
    namespace "omg.org/UML1.3", "UML"

    map_element "Collaboration", to: :collaboration
  end
end
