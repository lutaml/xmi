# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Project < Lutaml::Model::Serializable
        attribute :author, :string
        attribute :version, :string
        attribute :phase, :string
        attribute :created, :string
        attribute :modified, :string
        attribute :complexity, :integer
        attribute :status, :string

        xml do
          root "project"

          map_attribute "author", to: :author
          map_attribute "version", to: :version
          map_attribute "phase", to: :phase
          map_attribute "created", to: :created
          map_attribute "modified", to: :modified
          map_attribute "complexity", to: :complexity
          map_attribute "status", to: :status
        end
      end
    end
  end
end
