# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class Model < Lutaml::Model::Serializable
        attribute :ea_localid, :string
        attribute :type, ::Xmi::Type::XmiType
        attribute :name, :string

        xml do
          map_attribute "ea_localid", to: :ea_localid
          map_attribute "type", to: :type
          map_attribute "name", to: :name
        end
      end

      class EndRole < Lutaml::Model::Serializable
        attribute :name, :string
        attribute :visibility, :string
        attribute :target_scope, :string

        xml do
          root "role"

          map_attribute :name, to: :name
          map_attribute :visibility, to: :visibility
          map_attribute :targetScope, to: :target_scope
        end
      end

      class EndType < Lutaml::Model::Serializable
        attribute :aggregation, :string
        attribute :multiplicity, :string
        attribute :containment, :string

        xml do
          root "type"

          map_attribute :aggregation, to: :aggregation
          map_attribute :multiplicity, to: :multiplicity
          map_attribute :containment, to: :containment
        end
      end

      class EndModifiers < Lutaml::Model::Serializable
        attribute :is_ordered, :boolean
        attribute :is_navigable, :boolean

        xml do
          root "type"

          map_attribute "isOrdered", to: :is_ordered
          map_attribute "isNavigable", to: :is_navigable
        end
      end

      class EndConstraint < Lutaml::Model::Serializable
        attribute :name, :string
        attribute :type, ::Xmi::Type::XmiType
        attribute :weight, :float
        attribute :status, :string

        xml do
          root "constraint"

          map_attribute "name", to: :name
          map_attribute "type", to: :type
          map_attribute "weight", to: :weight
          map_attribute "status", to: :status
        end
      end

      class EndConstraints < Lutaml::Model::Serializable
        attribute :constraint, EndConstraint, collection: true

        xml do
          root "constraints"

          map_element "constraint", to: :constraint, value_map: VALUE_MAP
        end
      end

      class EndStyle < Lutaml::Model::Serializable
        attribute :value, :string

        xml do
          root "style"

          map_attribute "value", to: :value
        end
      end

      class End < Lutaml::Model::Serializable
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
        xml do
          root "source"

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
        xml do
          root "target"

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

      class Properties < Lutaml::Model::Serializable
        attribute :ea_type, :string
        attribute :direction, :string

        xml do
          root "properties"

          map_attribute :ea_type, to: :ea_type
          map_attribute :direction, to: :direction
        end
      end

      class Appearance < Lutaml::Model::Serializable
        attribute :linemode, :integer
        attribute :linecolor, :integer
        attribute :linewidth, :integer
        attribute :seqno, :integer
        attribute :headStyle, :integer
        attribute :lineStyle, :integer

        xml do
          root "appearance"

          map_attribute :linemode, to: :linemode
          map_attribute :linecolor, to: :linecolor
          map_attribute :linewidth, to: :linewidth
          map_attribute :seqno, to: :seqno
          map_attribute :headStyle, to: :headStyle
          map_attribute :lineStyle, to: :lineStyle
        end
      end

      class Labels < Lutaml::Model::Serializable
        attribute :rb, :string
        attribute :lb, :string
        attribute :mb, :string
        attribute :rt, :string
        attribute :lt, :string
        attribute :mt, :string

        xml do
          root "labels"

          map_attribute :rb, to: :rb
          map_attribute :lb, to: :lb
          map_attribute :mb, to: :mb
          map_attribute :rt, to: :rt
          map_attribute :lt, to: :lt
          map_attribute :mt, to: :mt
        end
      end

      class Connector < Lutaml::Model::Serializable
        attribute :name, :string
        attribute :idref, :string
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
