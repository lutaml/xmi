# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class ExtendedProperties < Lutaml::Model::Serializable
        attribute :tagged, :string
        attribute :package_name, :string
        attribute :virtual_inheritance, :integer

        xml do
          root "extendedProperties"

          map_attribute "tagged", to: :tagged
          map_attribute "package_name", to: :package_name
          map_attribute "virtualInheritance", to: :virtual_inheritance
        end
      end
    end
  end
end
