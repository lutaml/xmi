# frozen_string_literal: true

module Xmi
  module CustomProfile
    class Enumeration < Lutaml::Model::Serializable
      attribute :base_enumeration, :string

      xml do
        element "enumeration"
        namespace ::Xmi::Namespace::Sparx::CustomProfile

        map_attribute "base_Enumeration", to: :base_enumeration
      end
    end
  end
end
