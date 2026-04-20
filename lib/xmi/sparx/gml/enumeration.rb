# frozen_string_literal: true

module Xmi
  module Sparx
    module Gml
      class Enumeration < Lutaml::Model::Serializable
        attribute :base_enumeration, :string

        xml do
          root "Enumeration"
          namespace ::Xmi::Namespace::Sparx::Gml

          map_attribute "base_Enumeration", to: :base_enumeration
        end
      end
    end
  end
end
