# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Xrefs < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :value, :string

        xml do
          root "xrefs"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute "value", to: :value
        end
      end
    end
  end
end
