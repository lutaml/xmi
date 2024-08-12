# frozen_string_literal: true

require "shale"

require_relative "generalization"

class GeneralizableElementspecialization < Shale::Mapper
  attribute :generalization, Generalization, collection: true

  xml do
    root "GeneralizableElement.specialization"
    namespace "omg.org/UML1.3", "UML"

    map_element "Generalization", to: :generalization
  end
end
