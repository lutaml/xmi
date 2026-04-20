# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Coords < Lutaml::Model::Serializable
        attribute :ordered, :integer
        attribute :scale, :integer

        xml do
          root "coords"

          map_attribute "ordered", to: :ordered
          map_attribute "scale", to: :scale
        end
      end
    end
  end
end
