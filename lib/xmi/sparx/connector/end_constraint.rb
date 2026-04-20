# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class EndConstraint < Lutaml::Model::Serializable
        attribute :name, :string
        attribute :type, ::Xmi::Type::XmiType
        attribute :weight, :float
        attribute :status, :string

        xml do
          root "constraint"

          map_attribute "name", to: :name
          map_attribute "type", to: :type
          map_attribute "weight", to: :weight
          map_attribute "status", to: :status
        end
      end

      class EndConstraints < Lutaml::Model::Serializable
        attribute :constraint, EndConstraint, collection: true

        xml do
          root "constraints"

          map_element "constraint", to: :constraint, value_map: VALUE_MAP
        end
      end
    end
  end
end
