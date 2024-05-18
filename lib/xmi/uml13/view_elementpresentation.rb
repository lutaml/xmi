# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class Presentation < Shale::Mapper
    end

    class ViewElementpresentation < Shale::Mapper
      attribute :presentation, Presentation, collection: true

      xml do
        root "ViewElement.presentation"
        namespace "omg.org/UML1.3", "UML"

        map_element "Presentation", to: :presentation
      end
    end
  end
end
