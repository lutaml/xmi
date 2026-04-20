# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class Properties < Lutaml::Model::Serializable
        attribute :ea_type, :string
        attribute :direction, :string

        xml do
          root "properties"

          map_attribute :ea_type, to: :ea_type
          map_attribute :direction, to: :direction
        end
      end
    end
  end
end
