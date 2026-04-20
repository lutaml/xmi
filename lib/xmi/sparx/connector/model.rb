# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class Model < Lutaml::Model::Serializable
        attribute :ea_localid, :string
        attribute :type, ::Xmi::Type::XmiType
        attribute :name, :string

        xml do
          map_attribute "ea_localid", to: :ea_localid
          map_attribute "type", to: :type
          map_attribute "name", to: :name
        end
      end
    end
  end
end
