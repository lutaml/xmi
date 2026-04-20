# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Code < Lutaml::Model::Serializable
        attribute :gentype, :string
        attribute :product_name, :string

        xml do
          root "code"

          map_attribute "gentype", to: :gentype
          map_attribute "product_name", to: :product_name
        end
      end
    end
  end
end
