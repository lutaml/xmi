# frozen_string_literal: true

require "shale"

require_relative "generalization"

module Xmi
  module Uml13
    class GeneralizableElementgeneralization < Shale::Mapper
      attribute :generalization, Generalization, collection: true

      xml do
        root "GeneralizableElement.generalization"
        namespace "omg.org/UML1.3", "UML"

        map_element "Generalization", to: :generalization
      end
    end
  end
end
