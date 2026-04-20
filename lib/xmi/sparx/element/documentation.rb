# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Documentation < Lutaml::Model::Serializable
        attribute :value, :string

        xml do
          root "documentation"

          map_attribute "value", to: :value
        end
      end
    end
  end
end
