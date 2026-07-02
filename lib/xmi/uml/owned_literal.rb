# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedLiteral < Base
      attribute :name, :string
      attribute :uml_type, Uml::Type

      xml do
        root "ownedLiteral"
        map_attribute "name", to: :name
        map_element "type", to: :uml_type
      end
    end
  end
end
