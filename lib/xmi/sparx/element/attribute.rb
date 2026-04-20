# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Attribute < Lutaml::Model::Serializable
        attribute :idref, ::Xmi::Type::XmiIdRef
        attribute :name, :string
        attribute :scope, :string
        attribute :initial, :string
        attribute :documentation, Documentation
        attribute :options, :string
        attribute :style, :string
        attribute :tags, :string, collection: true
        attribute :model, Model
        attribute :properties, Properties
        attribute :coords, Coords
        attribute :containment, Containment
        attribute :stereotype, Stereotype
        attribute :bounds, Bounds
        attribute :styleex, Styleex
        attribute :xrefs, Xrefs

        xml do
          root "attribute"

          map_attribute "idref", to: :idref
          map_attribute "name", to: :name
          map_attribute "scope", to: :scope

          map_element "initial", to: :initial
          map_element "options", to: :options
          map_element "style", to: :style
          map_element "tags", to: :tags, value_map: VALUE_MAP
          map_element "documentation", to: :documentation
          map_element "model", to: :model
          map_element "properties", to: :properties
          map_element "coords", to: :coords
          map_element "containment", to: :containment
          map_element "stereotype", to: :stereotype
          map_element "bounds", to: :bounds
          map_element "styleex", to: :styleex
          map_element "xrefs", to: :xrefs
        end
      end

      class Attributes < Lutaml::Model::Serializable
        attribute :attribute, Attribute, collection: true

        xml do
          root "attributes"

          map_element "attribute", to: :attribute, value_map: VALUE_MAP
        end
      end
    end
  end
end
