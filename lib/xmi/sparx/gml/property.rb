# frozen_string_literal: true

module Xmi
  module Sparx
    module Gml
      class Property < Lutaml::Model::Serializable
        attribute :sequence_number, :string
        attribute :base_property, :string
        attribute :is_metadata, :string
        attribute :inline_or_by_reference, :string

        xml do
          root "property"
          namespace ::Xmi::Namespace::Sparx::Gml

          map_attribute "sequenceNumber", to: :sequence_number
          map_attribute "base_Property", to: :base_property
          map_attribute "isMetadata", to: :is_metadata
          map_attribute "inlineOrByReference", to: :inline_or_by_reference
        end
      end
    end
  end
end
