# frozen_string_literal: true

require "shale"
require_relative "documentation"
require_relative "uml"

module Xmi
  module RootAttributes
    def self.included(klass)
      klass.class_eval do
        attribute :id, Shale::Type::String
        attribute :label, Shale::Type::String
        attribute :uuid, Shale::Type::String
        attribute :href, Shale::Type::String
        attribute :idref, Shale::Type::String
        attribute :type, Shale::Type::String
        attribute :documentation, Documentation
      end
    end
  end

  class Root < Shale::Mapper
    include RootAttributes
    attribute :model, Uml::UmlModel

    xml do
      root "XMI"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmi"

      map_attribute "id", to: :id
      map_attribute "label", to: :label
      map_attribute "uuid", to: :uuid
      map_attribute "href", to: :href, namespace: nil, prefix: nil
      map_attribute "idref", to: :idref
      map_attribute "type", to: :type

      map_element "Documentation", to: :documentation
      map_element "Model", to: :model,
                           namespace: "http://www.omg.org/spec/UML/20161101",
                           prefix: "uml"
    end
  end

  class Root2013 < Shale::Mapper
    include RootAttributes
    attribute :model, Uml::UmlModel2013

    xml do
      root "XMI"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmi"

      map_attribute "id", to: :id
      map_attribute "label", to: :label
      map_attribute "uuid", to: :uuid
      map_attribute "href", to: :href, namespace: nil, prefix: nil
      map_attribute "idref", to: :idref
      map_attribute "type", to: :type

      map_element "Documentation", to: :documentation
      map_element "Model", to: :model,
                           namespace: "http://www.omg.org/spec/UML/20131001",
                           prefix: "uml"
    end
  end
end
