# frozen_string_literal: true

require_relative "extension"

module Xmi
  class Documentation < Lutaml::Model::Serializable
    attribute :id, ::Xmi::Type::XmiId
    attribute :label, ::Xmi::Type::XmiLabel
    attribute :uuid, ::Xmi::Type::XmiUuid
    attribute :href, :string
    attribute :idref, ::Xmi::Type::XmiIdRef
    attribute :type, ::Xmi::Type::XmiType
    attribute :contact, :string, collection: true
    attribute :exporter, :string
    attribute :exporter_version, :string
    attribute :exporter_id, :string
    attribute :long_description, :string, collection: true
    attribute :short_description, :string, collection: true
    attribute :notice, :string, collection: true
    attribute :owner, :string, collection: true
    attribute :timestamp, :time, collection: true
    attribute :extension, Extension, collection: true

    xml do
      root "Documentation"
      namespace ::Xmi::Namespace::Omg::Xmi

      map_attribute "id", to: :id
      map_attribute "label", to: :label
      map_attribute "uuid", to: :uuid
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref
      map_attribute "type", to: :type
      map_attribute "exporter", to: :exporter
      map_attribute "exporterVersion", to: :exporter_version
      map_attribute "exporterID", to: :exporter_id

      map_element "contact", to: :contact, value_map: VALUE_MAP
      map_element "longDescription", to: :long_description, value_map: VALUE_MAP
      map_element "shortDescription", to: :short_description,
                                      value_map: VALUE_MAP
      map_element "notice", to: :notice, value_map: VALUE_MAP
      map_element "owner", to: :owner, value_map: VALUE_MAP
      map_element "timestamp", to: :timestamp, value_map: VALUE_MAP
      map_element "Extension", to: :extension, value_map: VALUE_MAP
    end
  end
end
