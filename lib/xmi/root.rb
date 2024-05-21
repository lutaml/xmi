# frozen_string_literal: true

require "shale"
require_relative "documentation"
require_relative "uml"

module Xmi
  class Root < Shale::Mapper
    attribute :id, Shale::Type::String
    attribute :label, Shale::Type::String
    attribute :uuid, Shale::Type::String
    attribute :href, Shale::Type::String
    attribute :idref, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :documentation, Documentation
    attribute :model, Uml::UmlModel
    attribute :extension, Extension

    xml do
      root "XMI"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmi"

      map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "label", to: :label, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "uuid", to: :uuid, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "type", to: :type, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

      map_element "Documentation", to: :documentation,
                                   prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

      map_element "Model", to: :model,
                           namespace: "http://www.omg.org/spec/UML/20131001",
                           prefix: "uml"

      map_element "Extension", to: :extension,
                               namespace: "http://www.omg.org/spec/XMI/20131001",
                               prefix: "xmi"
    end
  end
end
