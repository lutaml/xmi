# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Style < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :appearance, :string

        xml do
          root "style"

          map_attribute "appearance", to: :appearance
        end
      end
    end
  end
end
