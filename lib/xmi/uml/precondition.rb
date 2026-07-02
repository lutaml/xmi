# frozen_string_literal: true

module Xmi
  module Uml
    class Precondition < Base
      attribute :name, :string
      attribute :specification, Specification

      xml do
        root "precondition"
        map_attribute "name", to: :name
        map_element "specification", to: :specification
      end
    end
  end
end
