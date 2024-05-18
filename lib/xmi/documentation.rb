# frozen_string_literal: true

require "shale"

require_relative "extension"

module Xmi
  class Documentation < Shale::Mapper
    attribute :id, Shale::Type::Value
    attribute :label, Shale::Type::String
    attribute :uuid, Shale::Type::String
    attribute :href, Shale::Type::Value
    attribute :idref, Shale::Type::Value
    attribute :type, Shale::Type::Value
    attribute :contact, Shale::Type::String, collection: true
    attribute :exporter, Shale::Type::String
    attribute :exporter_version, Shale::Type::String
    attribute :exporter_id, Shale::Type::String
    attribute :long_description, Shale::Type::String, collection: true
    attribute :short_description, Shale::Type::String, collection: true
    attribute :notice, Shale::Type::String, collection: true
    attribute :owner, Shale::Type::String, collection: true
    attribute :timestamp, Shale::Type::Time, collection: true
    attribute :extension, Extension, collection: true

    xml do
      root "Documentation"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmlns"

      map_attribute "id", to: :id, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "label", to: :label, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "uuid", to: :uuid, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "type", to: :type, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "exporter", to: :exporter
      map_attribute "exporterVersion", to: :exporter_version
      map_attribute "exporterID", to: :exporter_id

      map_element "contact", to: :contact, prefix: nil, namespace: nil
      map_element "longDescription", to: :long_description, prefix: nil, namespace: nil
      map_element "shortDescription", to: :short_description, prefix: nil, namespace: nil
      map_element "notice", to: :notice, prefix: nil, namespace: nil
      map_element "owner", to: :owner, prefix: nil, namespace: nil
      map_element "timestamp", to: :timestamp, prefix: nil, namespace: nil
      map_element "Extension", to: :extension
    end
  end
end
