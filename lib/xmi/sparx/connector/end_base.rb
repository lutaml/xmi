# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class End < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :idref, ::Xmi::Type::XmiIdRef
        attribute :model, Model
        attribute :role, EndRole
        attribute :type, EndType
        attribute :constraints, EndConstraints
        attribute :modifiers, EndModifiers
        attribute :style, EndStyle
        attribute :documentation, Element::Documentation
        attribute :xrefs, Element::Xrefs
        attribute :tags, Element::Tags
      end

      class Source < End
        skip_reference_registration
        xml do
          root "source"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute "idref", to: :idref

          map_element "model", to: :model, render_nil: true
          map_element "role", to: :role, render_nil: true
          map_element "type", to: :type, render_nil: true
          map_element "constraints", to: :constraints, render_nil: true
          map_element "modifiers", to: :modifiers, render_nil: true
          map_element "style", to: :style, render_nil: true
          map_element "documentation", to: :documentation, value_map: VALUE_MAP
          map_element "xrefs", to: :xrefs, render_nil: true
          map_element "tags", to: :tags, render_nil: true
        end
      end

      class Target < End
        skip_reference_registration
        xml do
          root "target"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute "idref", to: :idref

          map_element "model", to: :model, render_nil: true
          map_element "role", to: :role, render_nil: true
          map_element "type", to: :type, render_nil: true
          map_element "constraints", to: :constraints, render_nil: true
          map_element "modifiers", to: :modifiers, render_nil: true
          map_element "style", to: :style, render_nil: true
          map_element "documentation", to: :documentation, value_map: VALUE_MAP
          map_element "xrefs", to: :xrefs, render_nil: true
          map_element "tags", to: :tags, render_nil: true
        end
      end
    end
  end
end
