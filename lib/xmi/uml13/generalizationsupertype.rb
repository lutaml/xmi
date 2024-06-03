# frozen_string_literal: true

require "shale"

require_relative "generalizable_element"

module Xmi
  module Uml13
    class Generalizationsupertype < Shale::Mapper
      attribute :generalizable_element, GeneralizableElement, collection: true

      xml do
        root "Generalization.supertype"
        namespace "omg.org/UML1.3", "UML"

        map_element "GeneralizableElement", to: :generalizable_element
      end
    end
  end
end
