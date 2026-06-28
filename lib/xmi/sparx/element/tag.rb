# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Tag < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :id, ::Xmi::Type::XmiId
        attribute :name, :string
        attribute :value, :string
        attribute :model_element, :string

        xml do
          root "tag"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute "id", to: :id
          map_attribute "name", to: :name
          map_attribute "value", to: :value
          map_attribute "modelElement", to: :model_element
        end
      end

      class Tags < Lutaml::Model::Serializable
        attribute :tags, Tag, collection: true

        xml do
          root "tags"
          namespace ::Xmi::Namespace::Omg::Xmi
          map_element "tag", to: :tags, value_map: VALUE_MAP
        end
      end
    end
  end
end
