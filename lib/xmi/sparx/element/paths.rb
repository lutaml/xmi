# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Paths < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :xmlpath, :string

        xml do
          root "paths"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute "xmlpath", to: :xmlpath
        end
      end
    end
  end
end
