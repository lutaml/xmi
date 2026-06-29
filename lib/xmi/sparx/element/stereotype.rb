# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Stereotype < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :stereotype, :string

        xml do
          root "stereotype"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute "stereotype", to: :stereotype
        end
      end
    end
  end
end
