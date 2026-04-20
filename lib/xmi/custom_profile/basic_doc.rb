# frozen_string_literal: true

module Xmi
  module CustomProfile
    class BasicDoc < Lutaml::Model::Serializable
      attribute :base_class, :string

      xml do
        element "BasicDoc"
        namespace ::Xmi::Namespace::Sparx::CustomProfile

        map_attribute "base_Class", to: :base_class
      end
    end
  end
end
