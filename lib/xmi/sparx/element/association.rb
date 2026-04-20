# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Association < Lutaml::Model::Serializable
        attribute :id, ::Xmi::Type::XmiId
        attribute :start, :string
        attribute :end, :string
        attribute :name, :string, default: -> { "Association" }

        xml do
          root "Association"

          map_attribute "id", to: :id
          map_attribute "start", to: :start
          map_attribute "end", to: :end
        end
      end

      class Generalization < Association
        attribute :name, :string, default: -> { "Generalization" }

        xml do
          root "Generalization"

          map_attribute "id", to: :id
          map_attribute "start", to: :start
          map_attribute "end", to: :end
        end
      end

      class Aggregation < Association
        attribute :name, :string, default: -> { "Aggregation" }

        xml do
          root "Aggregation"

          map_attribute "id", to: :id
          map_attribute "start", to: :start
          map_attribute "end", to: :end
        end
      end

      class NoteLink < Association
        attribute :name, :string, default: -> { "NoteLink" }

        xml do
          root "NoteLink"

          map_attribute "id", to: :id
          map_attribute "start", to: :start
          map_attribute "end", to: :end
        end
      end
    end
  end
end
