# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Containment < Lutaml::Model::Serializable
        attribute :containment, :string
        attribute :position, :integer

        xml do
          root "containment"

          map_attribute "containment", to: :containment
          map_attribute "position", to: :position
        end
      end
    end
  end
end
