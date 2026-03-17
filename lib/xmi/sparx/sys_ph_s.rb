# frozen_string_literal: true

module Xmi
  module Sparx
    class SysPhS < Lutaml::Model::Serializable
      attribute :base_package, :string
      attribute :name, :string

      xml do
        root "ModelicaParameter"
        namespace ::Xmi::Namespace::Sparx::SysPhS

        map_attribute "base_Package", to: :base_package
        map_attribute "name", to: :name
      end
    end
  end
end
