# frozen_string_literal: true

module Xmi
  module CustomProfile
    class BasicDoc < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :base_class, :string

      xml do
        element "BasicDoc"
        namespace ::Xmi::Namespace::Sparx::CustomProfile

        map_attribute "base_Class", to: :base_class
      end
    end
  end
end
