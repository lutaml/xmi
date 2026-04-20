# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Stereotype < Lutaml::Model::Serializable
        attribute :stereotype, :string

        xml do
          root "stereotype"

          map_attribute "stereotype", to: :stereotype
        end
      end
    end
  end
end
