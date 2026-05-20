# frozen_string_literal: true

module Xmi
  module CustomProfile
    class Number < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :base_package, :string
      attribute :number, :string

      xml do
        element "number"
        namespace ::Xmi::Namespace::Sparx::CustomProfile

        map_attribute "base_Package", to: :base_package
        map_attribute "number", to: :number
      end
    end
  end
end
