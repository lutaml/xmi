# frozen_string_literal: true

require "shale"

require_relative "operation"

module Xmi
  module Uml13
    class Methodspecification < Shale::Mapper
      attribute :operation, Operation, collection: true

      xml do
        root "Method.specification"
        namespace "omg.org/UML1.3", "UML"

        map_element "Operation", to: :operation
      end
    end
  end
end
