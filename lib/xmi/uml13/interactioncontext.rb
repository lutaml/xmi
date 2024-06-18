# frozen_string_literal: true

require "shale"

require_relative "collaboration"

class Interactioncontext < Shale::Mapper
  attribute :collaboration, Collaboration, collection: true

  xml do
    root "Interaction.context"
    namespace "omg.org/UML1.3", "UML"

    map_element "Collaboration", to: :collaboration
  end
end
