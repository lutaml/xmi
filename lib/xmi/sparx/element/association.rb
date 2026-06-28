# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Association < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :id, ::Xmi::Type::XmiId
        attribute :start, :string
        attribute :end, :string
        attribute :name, :string, default: -> { "Association" }

        xml do
          root "Association"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute "id", to: :id
          map_attribute "start", to: :start
          map_attribute "end", to: :end
        end
      end

      class Generalization < Association
        skip_reference_registration
        attribute :name, :string, default: -> { "Generalization" }

        xml do
          root "Generalization"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute "id", to: :id
          map_attribute "start", to: :start
          map_attribute "end", to: :end
        end
      end

      class Aggregation < Association
        skip_reference_registration
        attribute :name, :string, default: -> { "Aggregation" }

        xml do
          root "Aggregation"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute "id", to: :id
          map_attribute "start", to: :start
          map_attribute "end", to: :end
        end
      end

      class NoteLink < Association
        skip_reference_registration
        attribute :name, :string, default: -> { "NoteLink" }

        xml do
          root "NoteLink"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute "id", to: :id
          map_attribute "start", to: :start
          map_attribute "end", to: :end
        end
      end
    end
  end
end
