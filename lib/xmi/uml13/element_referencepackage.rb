# frozen_string_literal: true

require "shale"

require_relative "package"

module Xmi
  module Uml13
    class ElementReferencepackage < Shale::Mapper
      attribute :package, Package, collection: true

      xml do
        root "ElementReference.package"
        namespace "omg.org/UML1.3", "UML"

        map_element "Package", to: :package
      end
    end
  end
end
