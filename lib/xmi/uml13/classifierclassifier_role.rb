# frozen_string_literal: true

require "shale"

require_relative "classifier_role"

module Xmi
  module Uml13
    class ClassifierRole < Shale::Mapper
    end

    class ClassifierclassifierRole < Shale::Mapper
      attribute :classifier_role, ClassifierRole, collection: true

      xml do
        root "Classifier.classifierRole"
        namespace "omg.org/UML1.3", "UML"

        map_element "ClassifierRole", to: :classifier_role
      end
    end
  end
end
