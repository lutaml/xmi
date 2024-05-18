# frozen_string_literal: true

require "shale"

require_relative "dependency"

module Xmi
  module Uml13
    class ModelElementprovision < Shale::Mapper
      attribute :dependency, Dependency, collection: true

      xml do
        root "ModelElement.provision"
        namespace "omg.org/UML1.3", "UML"

        map_element "Dependency", to: :dependency
      end
    end
  end
end
