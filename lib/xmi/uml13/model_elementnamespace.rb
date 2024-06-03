# frozen_string_literal: true

require "shale"

require_relative "namespace"

module Xmi
  module Uml13
    class ModelElementnamespace < Shale::Mapper
      attribute :namespace, Namespace, collection: true

      xml do
        root "ModelElement.namespace"
        namespace "omg.org/UML1.3", "UML"

        map_element "Namespace", to: :namespace
      end
    end
  end
end
