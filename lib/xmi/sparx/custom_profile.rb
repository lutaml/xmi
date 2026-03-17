# frozen_string_literal: true

module Xmi
  module Sparx
    module CustomProfile
      # Contains UML Profile definitions
      # Note: PublicationDate, Edition, Number, YearVersion are defined in Xmi::CustomProfile
      class Profiles < Lutaml::Model::Serializable
        attribute :profile, Uml::Profile, collection: true

        xml do
          root "profiles"

          map_element "Profile", to: :profile, value_map: VALUE_MAP
        end
      end
    end
  end
end
