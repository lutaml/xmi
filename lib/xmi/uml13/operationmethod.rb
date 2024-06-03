# frozen_string_literal: true

require "shale"

require_relative "method"

module Xmi
  module Uml13
    class Operationmethod < Shale::Mapper
      attribute :method, Method, collection: true

      xml do
        root "Operation.method"
        namespace "omg.org/UML1.3", "UML"

        map_element "Method", to: :method
      end
    end
  end
end
