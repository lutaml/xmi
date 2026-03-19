# frozen_string_literal: true

require_relative "extension"

module Xmi
  class Difference < Lutaml::Model::Serializable
    attribute :id, ::Xmi::Type::XmiId
    attribute :label, ::Xmi::Type::XmiLabel
    attribute :uuid, ::Xmi::Type::XmiUuid
    attribute :href, :string
    attribute :idref, ::Xmi::Type::XmiIdRef
    attribute :type, ::Xmi::Type::XmiType
    attribute :target, :string
    attribute :container, :string
    attribute :difference, Difference, collection: true
    attribute :extension, Extension, collection: true

    xml do
      root "Difference"
      namespace ::Xmi::Namespace::Omg::Xmi

      map_attribute "id", to: :id
      map_attribute "label", to: :label
      map_attribute "uuid", to: :uuid
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref
      map_attribute "type", to: :type
      map_attribute "target", to: :target
      map_attribute "container", to: :container
      map_element "difference", to: :difference, value_map: VALUE_MAP
      map_element "Extension", to: :extension, value_map: VALUE_MAP
    end
  end
end
