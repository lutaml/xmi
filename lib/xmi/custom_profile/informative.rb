# frozen_string_literal: true

module Xmi
  module CustomProfile
    class Informative < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :base_package, :string

      xml do
        element "informative"
        namespace ::Xmi::Namespace::Sparx::CustomProfile

        map_attribute "base_Package", to: :base_package
      end
    end
  end
end
