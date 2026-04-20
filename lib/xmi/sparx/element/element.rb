# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Element < Lutaml::Model::Serializable
        attribute :idref, ::Xmi::Type::XmiIdRef
        attribute :type, ::Xmi::Type::XmiType
        attribute :name, :string
        attribute :scope, :string
        attribute :model, Model
        attribute :properties, Properties
        attribute :project, Project
        attribute :code, Code
        attribute :style, Style
        attribute :tags, Tags
        attribute :xrefs, Xrefs
        attribute :extended_properties, ExtendedProperties
        attribute :package_properties, PackageProperties
        attribute :paths, Paths
        attribute :times, Times
        attribute :flags, Flags
        attribute :links, Links, collection: true
        attribute :attributes, Attributes

        xml do
          root "element"

          map_attribute "idref", to: :idref
          map_attribute "type", to: :type
          map_attribute "name", to: :name
          map_attribute "scope", to: :scope

          map_element "model", to: :model
          map_element "properties", to: :properties
          map_element "project", to: :project
          map_element "code", to: :code
          map_element "style", to: :style
          map_element "tags", to: :tags
          map_element "xrefs", to: :xrefs
          map_element "extendedProperties", to: :extended_properties
          map_element "packageproperties", to: :package_properties
          map_element "paths", to: :paths
          map_element "times", to: :times
          map_element "flags", to: :flags
          map_element "links", to: :links
          map_element "attributes", to: :attributes
        end
      end

      class Elements < Lutaml::Model::Serializable
        attribute :element, Element, collection: true

        xml do
          root "elements"

          map_element "element", to: :element, value_map: VALUE_MAP
        end
      end
    end
  end
end
