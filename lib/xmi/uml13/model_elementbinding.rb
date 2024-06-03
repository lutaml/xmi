# frozen_string_literal: true

require "shale"

require_relative "binding"

module Xmi
  module Uml13
    class ModelElementbinding < Shale::Mapper
      attribute :binding, Binding, collection: true

      xml do
        root "ModelElement.binding"
        namespace "omg.org/UML1.3", "UML"

        map_element "Binding", to: :binding
      end
    end
  end
end
