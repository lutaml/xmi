# frozen_string_literal: true

require "shale"

require_relative "enumeration"

module Xmi
  module Uml13
    class EnumerationLiteralenumeration < Shale::Mapper
      attribute :enumeration, Enumeration, collection: true

      xml do
        root "EnumerationLiteral.enumeration"
        namespace "omg.org/UML1.3", "UML"

        map_element "Enumeration", to: :enumeration
      end
    end
  end
end
