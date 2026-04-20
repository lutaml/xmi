# frozen_string_literal: true

module Xmi
  module CustomProfile
    class Persistence < Lutaml::Model::Serializable
      attribute :base_class, :string
      attribute :base_enumeration, :string
      attribute :persistence, :string

      xml do
        element "persistence"
        namespace ::Xmi::Namespace::Sparx::CustomProfile

        map_attribute "base_Class", to: :base_class
        map_attribute "base_Enumeration", to: :base_enumeration
        map_attribute "persistence", to: :persistence
      end
    end
  end
end
