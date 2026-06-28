# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class PackageProperties < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :version, :string
        attribute :xmiver, :string
        attribute :tpos, :string

        xml do
          root "packagedproperties"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute "version", to: :version
          map_attribute "xmiver", to: :xmiver
          map_attribute "tpos", to: :tpos
        end
      end
    end
  end
end
