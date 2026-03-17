# frozen_string_literal: true

module Xmi
  module Sparx
    module EaUml
      class Import < Lutaml::Model::Serializable
        attribute :base_package_import, :string

        xml do
          root "import"
          namespace ::Xmi::Namespace::Sparx::EaUml

          map_attribute "base_PackageImport", to: :base_package_import
        end
      end
    end
  end
end
