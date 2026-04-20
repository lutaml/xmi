# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Bounds < Lutaml::Model::Serializable
        attribute :lower, :integer
        attribute :upper, :integer

        xml do
          root "bounds"

          map_attribute "lower", to: :lower
          map_attribute "upper", to: :upper
        end
      end
    end
  end
end
