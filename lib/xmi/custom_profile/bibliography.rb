# frozen_string_literal: true

module Xmi
  module CustomProfile
    class Bibliography < Lutaml::Model::Serializable
      attribute :base_class, :string

      xml do
        element "Bibliography"
        namespace ::Xmi::Namespace::Sparx::CustomProfile

        map_attribute "base_Class", to: :base_class
      end
    end
  end
end
