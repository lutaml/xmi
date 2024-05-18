# frozen_string_literal: true

require "shale"

require_relative "association_end"

module Xmi
  module Uml13
    class ClassifierassociationEnd < Shale::Mapper
      attribute :association_end, AssociationEnd, collection: true

      xml do
        root "Classifier.associationEnd"
        namespace "omg.org/UML1.3", "UML"

        map_element "AssociationEnd", to: :association_end
      end
    end
  end
end
