# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class EndStyle < Lutaml::Model::Serializable
        attribute :value, :string

        xml do
          root "style"

          map_attribute "value", to: :value
        end
      end
    end
  end
end
