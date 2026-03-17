# frozen_string_literal: true

module Xmi
  module Sparx
    module Diagram
      class Element < Lutaml::Model::Serializable
        attribute :geometry, :string
        attribute :subject, :string
        attribute :seqno, :integer
        attribute :style, :string

        xml do
          root "element"

          map_attribute "geometry", to: :geometry
          map_attribute "subject", to: :subject
          map_attribute "seqno", to: :seqno
          map_attribute "style", to: :style
        end
      end

      class Elements < Lutaml::Model::Serializable
        attribute :element, Element, collection: true

        xml do
          root "elements"

          map_element "element", to: :element, value_map: VALUE_MAP
        end
      end

      class Model < Lutaml::Model::Serializable
        attribute :package, :string
        attribute :local_id, :string
        attribute :owner, :string

        xml do
          root "model"

          map_attribute "package", to: :package
          map_attribute "localID", to: :local_id
          map_attribute "owner", to: :owner
        end
      end

      class Style < Lutaml::Model::Serializable
        attribute :value, :string

        xml do
          map_attribute "value", to: :value
        end
      end

      class Diagram < Lutaml::Model::Serializable
        attribute :id, ::Xmi::Type::XmiId
        attribute :model, Model
        attribute :properties, Sparx::Element::Properties
        attribute :project, Sparx::Element::Project
        attribute :style1, Style
        attribute :style2, Style
        attribute :swimlanes, Style
        attribute :matrixitems, Style
        attribute :extended_properties, Sparx::Element::ExtendedProperties
        attribute :xrefs, Sparx::Element::Xrefs
        attribute :elements, Elements

        xml do
          root "diagram"

          map_attribute "id", to: :id

          map_element "model", to: :model
          map_element "properties", to: :properties
          map_element "project", to: :project
          map_element "style1", to: :style1, render_nil: true
          map_element "style2", to: :style2, render_nil: true
          map_element "swimlanes", to: :swimlanes, render_nil: true
          map_element "matrixitems", to: :matrixitems, render_nil: true
          map_element "extendedProperties", to: :extended_properties,
                                            render_nil: true
          map_element "xrefs", to: :xrefs, render_nil: true
          map_element "elements", to: :elements
        end
      end

      class Diagrams < Lutaml::Model::Serializable
        attribute :diagram, Diagram, collection: true

        xml do
          root "diagrams"

          map_element "diagram", to: :diagram, value_map: VALUE_MAP
        end
      end
    end
  end
end
