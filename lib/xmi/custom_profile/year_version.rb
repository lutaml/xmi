# frozen_string_literal: true

module Xmi
  module CustomProfile
    class YearVersion < Lutaml::Model::Serializable
      attribute :base_package, :string
      attribute :year_version, :string

      xml do
        element "yearVersion"
        namespace ::Xmi::Namespace::Sparx::CustomProfile

        map_attribute "base_Package", to: :base_package
        map_attribute "yearVersion", to: :year_version
      end
    end
  end
end
