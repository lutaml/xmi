# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class Generalization < Shale::Mapper
    end

    class GeneralizableElementspecialization < Shale::Mapper
      attribute :generalization, Generalization, collection: true

      xml do
        root "GeneralizableElement.specialization"
        namespace "omg.org/UML1.3", "UML"

        map_element "Generalization", to: :generalization
      end
    end
  end
end
