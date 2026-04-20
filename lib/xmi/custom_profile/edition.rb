# frozen_string_literal: true

module Xmi
  module CustomProfile
    class Edition < Lutaml::Model::Serializable
      attribute :base_package, :string
      attribute :edition, :string

      xml do
        element "edition"
        namespace ::Xmi::Namespace::Sparx::CustomProfile

        map_attribute "base_Package", to: :base_package
        map_attribute "edition", to: :edition
      end
    end
  end
end
