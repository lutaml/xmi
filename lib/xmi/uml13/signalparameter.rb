# frozen_string_literal: true

require "shale"

require_relative "parameter"

module Xmi
  module Uml13
    class Signalparameter < Shale::Mapper
      attribute :parameter, Parameter, collection: true

      xml do
        root "Signal.parameter"
        namespace "omg.org/UML1.3", "UML"

        map_element "Parameter", to: :parameter
      end
    end
  end
end
