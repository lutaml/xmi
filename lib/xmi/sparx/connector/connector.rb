# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class Connector < Lutaml::Model::Serializable
        attribute :name, :string
        attribute :idref, ::Xmi::Type::XmiIdRef
        attribute :source, Source
        attribute :target, Target
        attribute :model, Model
        attribute :properties, Properties
        attribute :documentation, Element::Documentation
        attribute :appearance, Appearance
        attribute :labels, Labels
        attribute :extended_properties, Element::ExtendedProperties
        attribute :style, Element::Style
        attribute :tags, Element::Tags
        attribute :xrefs, Element::Xrefs

        xml do
          root "element"

          map_attribute "name", to: :name
          map_attribute "idref", to: :idref

          map_element "source", to: :source
          map_element "target", to: :target
          map_element "model", to: :model
          map_element "properties", to: :properties
          map_element "documentation", to: :documentation, value_map: VALUE_MAP
          map_element "appearance", to: :appearance
          map_element "labels", to: :labels, render_nil: true
          map_element "extendedProperties", to: :extended_properties
          map_element "style", to: :style, render_nil: true
          map_element "xrefs", to: :xrefs, render_nil: true
          map_element "tags", to: :tags, render_nil: true
        end
      end

      class Connectors < Lutaml::Model::Serializable
        attribute :connector, Connector, collection: true

        xml do
          root "connectors"

          map_element "connector", to: :connector, value_map: VALUE_MAP
        end
      end
    end
  end
end
