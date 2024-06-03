# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class Dependency < Shale::Mapper
    end

    class DependencyowningDependency < Shale::Mapper
      attribute :dependency, Dependency, collection: true

      xml do
        root "Dependency.owningDependency"
        namespace "omg.org/UML1.3", "UML"

        map_element "Dependency", to: :dependency
      end
    end
  end
end
