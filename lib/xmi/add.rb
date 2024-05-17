# frozen_string_literal: true

require "shale"

require_relative "difference"
require_relative "extension"

module Xmi
  class Add < Shale::Mapper
    attribute :id, Shale::Type::Value
    attribute :label, Shale::Type::String
    attribute :uuid, Shale::Type::String
    attribute :href, Shale::Type::Value
    attribute :idref, Shale::Type::Value
    attribute :type, Shale::Type::Value
    attribute :target, Shale::Type::Value
    attribute :container, Shale::Type::Value
    attribute :position, Shale::Type::Integer
    attribute :addition, Shale::Type::Value
    attribute :difference, Difference, collection: true
    attribute :extension, Extension, collection: true

    xml do
      root "Add"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmlns"

      map_attribute "id", to: :id, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "label", to: :label, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "uuid", to: :uuid, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "type", to: :type, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "target", to: :target
      map_attribute "container", to: :container
      map_attribute "position", to: :position
      map_attribute "addition", to: :addition
      map_element "difference", to: :difference, prefix: nil, namespace: nil
      map_element "Extension", to: :extension
    end
  end
end
