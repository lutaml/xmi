# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Times < Lutaml::Model::Serializable
        attribute :created, :string
        attribute :modified, :string
        attribute :last_load_date, :string
        attribute :last_save_date, :string

        xml do
          root "times"

          map_attribute "created", to: :created
          map_attribute "modified", to: :modified
          map_attribute "lastloaddate", to: :last_load_date
          map_attribute "lastsavedate", to: :last_save_date
        end
      end
    end
  end
end
