# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class EndModifiers < Lutaml::Model::Serializable
        attribute :is_ordered, :boolean
        attribute :is_navigable, :boolean

        xml do
          root "type"

          map_attribute "isOrdered", to: :is_ordered
          map_attribute "isNavigable", to: :is_navigable
        end
      end
    end
  end
end
