# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class ExtendedProperties < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :tagged, :string
        attribute :package_name, :string
        attribute :virtual_inheritance, :integer

        xml do
          root "extendedProperties"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute "tagged", to: :tagged
          map_attribute "package_name", to: :package_name
          map_attribute "virtualInheritance", to: :virtual_inheritance
        end
      end
    end
  end
end
