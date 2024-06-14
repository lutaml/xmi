# frozen_string_literal: true

module Xmi
  module Sparx
    class SparxElementModel < Shale::Mapper
      attribute :package, Shale::Type::String
      attribute :package2, Shale::Type::String
      attribute :tpos, Shale::Type::Integer
      attribute :ea_localid, Shale::Type::String
      attribute :ea_eleType, Shale::Type::String

      xml do
        root "model"

        map_attribute "package", to: :package
        map_attribute "package2", to: :package2
        map_attribute "tpos", to: :tpos
        map_attribute "ea_localid", to: :ea_localid
        map_attribute "ea_eleType", to: :ea_eleType
      end
    end

    class SparxElementProperties < Shale::Mapper
      attribute :name, Shale::Type::String
      attribute :type, Shale::Type::String
      attribute :is_specification, Shale::Type::Boolean
      attribute :is_root, Shale::Type::Boolean
      attribute :is_leaf, Shale::Type::Boolean
      attribute :is_abstract, Shale::Type::Boolean
      attribute :is_active, Shale::Type::Boolean
      attribute :s_type, Shale::Type::String
      attribute :n_type, Shale::Type::String
      attribute :scope, Shale::Type::String
      attribute :stereotype, Shale::Type::String
      attribute :alias, Shale::Type::String
      attribute :documentation, Shale::Type::String

      xml do
        root "properties"

        map_attribute "name", to: :name
        map_attribute "type", to: :type
        map_attribute "isSpecification", to: :is_specification
        map_attribute "isRoot", to: :is_root
        map_attribute "isLeaf", to: :is_leaf
        map_attribute "isAbstract", to: :is_abstract
        map_attribute "isActive", to: :is_active
        map_attribute "sType", to: :s_type
        map_attribute "nType", to: :n_type
        map_attribute "scope", to: :scope
        map_attribute "stereotype", to: :stereotype
        map_attribute "alias", to: :alias
        map_attribute "documentation", to: :documentation
      end
    end

    class SparxElementProject < Shale::Mapper
      attribute :author, Shale::Type::String
      attribute :version, Shale::Type::String
      attribute :phase, Shale::Type::String
      attribute :created, Shale::Type::String
      attribute :modified, Shale::Type::String
      attribute :complexity, Shale::Type::Integer
      attribute :status, Shale::Type::String

      xml do
        root "project"

        map_attribute "author", to: :author
        map_attribute "version", to: :version
        map_attribute "phase", to: :phase
        map_attribute "created", to: :created
        map_attribute "modified", to: :modified
        map_attribute "complexity", to: :complexity
        map_attribute "status", to: :status
      end
    end

    class SparxElementCode < Shale::Mapper
      attribute :gentype, Shale::Type::String
      attribute :product_name, Shale::Type::String

      xml do
        root "code"

        map_attribute "gentype", to: :gentype
        map_attribute "product_name", to: :product_name
      end
    end

    # <style appearance="BackColor=-1;BorderColor=-1;BorderWidth=-1;FontColor=-1;VSwimLanes=1;HSwimLanes=1;BorderStyle=0;"/>
    class SparxElementStyle < Shale::Mapper
      attribute :appearance, Shale::Type::String

      xml do
        root "style"

        map_attribute "appearance", to: :appearance
      end
    end

    class SparxElementTag < Shale::Mapper
      attribute :id, Shale::Type::String
      attribute :name, Shale::Type::String
      attribute :value, Shale::Type::String
      attribute :model_element, Shale::Type::String

      xml do
        root "tag"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "name", to: :name
        map_attribute "value", to: :value
        map_attribute "modelElement", to: :model_element
      end
    end

    class SparxElementTags < Shale::Mapper
      attribute :tags, SparxElementTag, collection: true

      xml do
        root "tags"
        map_element "tag", to: :tags
      end
    end

    class SparxElementXrefs < Shale::Mapper
      attribute :value, Shale::Type::String

      xml do
        root "xrefs"

        map_attribute "value", to: :value
      end
    end

    class SparxElementExtendedProperties < Shale::Mapper
      attribute :tagged, Shale::Type::String
      attribute :package_name, Shale::Type::String
      attribute :virtual_inheritance, Shale::Type::Integer

      xml do
        root "extendedProperties"

        map_attribute "tagged", to: :tagged
        map_attribute "package_name", to: :package_name
        map_attribute "virtualInheritance", to: :virtual_inheritance
      end
    end

    class SparxElementPackageProperties < Shale::Mapper
      attribute :version, Shale::Type::String
      attribute :xmiver, Shale::Type::String
      attribute :tpos, Shale::Type::String

      xml do
        root "packagedproperties"

        map_attribute "version", to: :version
        map_attribute "xmiver", to: :xmiver
        map_attribute "tpos", to: :tpos
      end
    end

    class SparxElementPaths < Shale::Mapper
      attribute :xmlpath, Shale::Type::String

      xml do
        root "paths"

        map_attribute "xmlpath", to: :xmlpath
      end
    end

    class SparxElementTimes < Shale::Mapper
      attribute :created, Shale::Type::String
      attribute :modified, Shale::Type::String
      attribute :last_load_date, Shale::Type::String
      attribute :last_save_date, Shale::Type::String

      xml do
        root "times"

        map_attribute "created", to: :created
        map_attribute "modified", to: :modified
        map_attribute "lastloaddate", to: :last_load_date
        map_attribute "lastsavedate", to: :last_save_date
      end
    end

    class SparxElementFlags < Shale::Mapper
      attribute :is_controlled, Shale::Type::Integer
      attribute :is_protected, Shale::Type::Integer
      attribute :batch_save, Shale::Type::Integer
      attribute :batch_load, Shale::Type::Integer
      attribute :used_td, Shale::Type::Integer
      attribute :log_xml, Shale::Type::Integer
      attribute :package_flags, Shale::Type::String

      xml do
        root "flags"

        map_attribute "iscontrolled", to: :is_controlled
        map_attribute "isprotected", to: :is_protected
        map_attribute "batchsave", to: :batch_save
        map_attribute "batchload", to: :batch_load
        map_attribute "usedtd", to: :used_td
        map_attribute "logxml", to: :log_xml
        map_attribute "packageFlags", to: :package_flags
      end
    end

    class SparxElementAssociation < Shale::Mapper
      attribute :id, Shale::Type::String
      attribute :start, Shale::Type::String
      attribute :end, Shale::Type::String
      attribute :name, Shale::Type::String, default: -> { "Association" }

      xml do
        root "Association"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "start", to: :start
        map_attribute "end", to: :end
      end
    end

    class SparxElementGeneralization < SparxElementAssociation
      attribute :name, Shale::Type::String, default: -> { "Generalization" }

      xml do
        root "Generalization"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "start", to: :start
        map_attribute "end", to: :end
      end
    end

    class SparxElementAggregation < SparxElementAssociation
      attribute :name, Shale::Type::String, default: -> { "Aggregation" }

      xml do
        root "Aggregation"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "start", to: :start
        map_attribute "end", to: :end
      end
    end

    class SparxElementNoteLink < SparxElementAssociation
      attribute :name, Shale::Type::String, default: -> { "NoteLink" }

      xml do
        root "NoteLink"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "start", to: :start
        map_attribute "end", to: :end
      end
    end

    class SparxElementStyleex < Shale::Mapper
      attribute :value, Shale::Type::String

      xml do
        root "styleex"

        map_attribute "value", to: :value
      end
    end

    class SparxElementBounds < Shale::Mapper
      attribute :lower, Shale::Type::Integer
      attribute :upper, Shale::Type::Integer

      xml do
        root "bounds"

        map_attribute "lower", to: :lower
        map_attribute "upper", to: :upper
      end
    end

    class SparxElementStereotype < Shale::Mapper
      attribute :stereotype, Shale::Type::String

      xml do
        root "stereotype"

        map_attribute "stereotype", to: :stereotype
      end
    end

    class SparxElementContainment < Shale::Mapper
      attribute :containment, Shale::Type::String
      attribute :position, Shale::Type::Integer

      xml do
        root "containment"

        map_attribute "containment", to: :containment
        map_attribute "position", to: :position
      end
    end

    class SparxElementCoords < Shale::Mapper
      attribute :ordered, Shale::Type::Integer
      attribute :scale, Shale::Type::Integer

      xml do
        root "coords"

        map_attribute "ordered", to: :ordered
        map_attribute "scale", to: :scale
      end
    end

    class SparxElementAttribute < Shale::Mapper
      attribute :initial, Shale::Type::String
      attribute :documentation, Shale::Type::String
      attribute :options, Shale::Type::String
      attribute :style, Shale::Type::String
      attribute :tags, Shale::Type::String, collection: true

      attribute :model, SparxElementModel
      attribute :properties, SparxElementProperties
      attribute :coords, SparxElementCoords
      attribute :containment, SparxElementContainment
      attribute :stereotype, SparxElementStereotype
      attribute :bounds, SparxElementBounds
      attribute :styleex, SparxElementStyleex
      attribute :xrefs, SparxElementXrefs

      xml do
        root "attribute"

        map_attribute "initial", to: :initial
        map_attribute "documentation", to: :documentation
        map_attribute "options", to: :options
        map_attribute "style", to: :style
        map_attribute "tags", to: :tags

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

    class SparxElementAttributes < Shale::Mapper
      attribute :attribute, SparxElementAttribute, collection: true

      xml do
        root "attributes"

        map_element "attribute", to: :attribute
      end
    end

    class SparxElementLinks < Shale::Mapper
      attribute :association, SparxElementAssociation, collection: true
      attribute :generalization, SparxElementGeneralization, collection: true
      attribute :note_link, SparxElementNoteLink, collection: true

      xml do
        root "links"

        map_element "Association", to: :association
        map_element "Generalization", to: :generalization
        map_element "NoteLink", to: :note_link
      end
    end

    class SparxElement < Shale::Mapper
      attribute :idref, Shale::Type::String
      attribute :type, Shale::Type::String
      attribute :name, Shale::Type::String
      attribute :scope, Shale::Type::String
      attribute :model, SparxElementModel
      attribute :properties, SparxElementProperties
      attribute :project, SparxElementProject
      attribute :code, SparxElementCode
      attribute :style, SparxElementStyle
      attribute :tags, SparxElementTags
      attribute :xrefs, SparxElementXrefs
      attribute :extended_properties, SparxElementExtendedProperties
      attribute :package_properties, SparxElementPackageProperties
      attribute :paths, SparxElementPaths
      attribute :times, SparxElementTimes
      attribute :flags, SparxElementFlags
      attribute :links, SparxElementLinks
      attribute :attributes, SparxElementAttributes

      xml do
        root "element"

        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "type", to: :type, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "name", to: :name
        map_attribute "scope", to: :scope

        map_element "model", to: :model
        map_element "properties", to: :properties
        map_element "project", to: :project
        map_element "code", to: :code
        map_element "style", to: :style
        map_element "tags", to: :tags
        map_element "xrefs", to: :xrefs
        map_element "extendedProperties", to: :extended_properties, namespace: nil, prefix: nil
        map_element "packageproperties", to: :package_properties
        map_element "paths", to: :paths
        map_element "times", to: :times
        map_element "flags", to: :flags
        map_element "links", to: :links
        map_element "attributes", to: :attributes
      end
    end

    class SparxElements < Shale::Mapper
      attribute :element, SparxElement, collection: true

      xml do
        root "elements"

        map_element "element", to: :element
      end
    end

    class SparxConnectorModel < Shale::Mapper
      attribute :ea_localid, Shale::Type::String
      attribute :type, Shale::Type::String
      attribute :name, Shale::Type::String

      xml do
        map_attribute "ea_localid", to: :ea_localid
        map_attribute "type", to: :type
        map_attribute "name", to: :name
      end
    end

    class SparxConnectorEndRole < Shale::Mapper
      attribute :name, Shale::Type::String
      attribute :visibility, Shale::Type::String
      attribute :target_scope, Shale::Type::String

      xml do
        root "role"

        map_attribute :name, to: :name
        map_attribute :visibility, to: :visibility
        map_attribute :targetScope, to: :target_scope
      end
    end

    class SparxConnectorEndType < Shale::Mapper
      attribute :aggregation, Shale::Type::String
      attribute :multiplicity, Shale::Type::String
      attribute :containment, Shale::Type::String

      xml do
        root "type"

        map_attribute :aggregation, to: :aggregation
        map_attribute :multiplicity, to: :multiplicity
        map_attribute :containment, to: :containment
      end
    end

    class SparxConnectorEndModifiers < Shale::Mapper
      attribute :is_ordered, Shale::Type::Boolean
      attribute :is_navigable, Shale::Type::Boolean

      xml do
        root "type"

        map_attribute "isOrdered", to: :is_ordered
        map_attribute "isNavigable", to: :is_navigable
      end
    end

    class SparxConnectorEndConstraint < Shale::Mapper
      attribute :name, Shale::Type::String
      attribute :type, Shale::Type::String
      attribute :weight, Shale::Type::Float
      attribute :status, Shale::Type::String

      xml do
        root "constraint"

        map_attribute "name", to: :name
        map_attribute "type", to: :type
        map_attribute "weight", to: :weight
        map_attribute "status", to: :status
      end
    end

    class SparxConnectorEndConstraints < Shale::Mapper
      attribute :constraint, SparxConnectorEndConstraint, collection: true
      xml do
        root "constraints"

        map_element "constraint", to: :constraint
      end
    end

    class SparxConnectorEndStyle < Shale::Mapper
      attribute :value, Shale::Type::String

      xml do
        root "style"

        map_attribute "value", to: :value
      end
    end

    module SparxConnectorEnd
      def self.included(klass)
        klass.class_eval do
          attribute :idref, Shale::Type::String
          attribute :model, SparxConnectorModel
          attribute :role, SparxConnectorEndRole
          attribute :type, SparxConnectorEndType
          attribute :constraints, SparxConnectorEndConstraints
          attribute :modifiers, SparxConnectorEndModifiers
          attribute :style, SparxConnectorEndStyle
          attribute :documentation, Shale::Type::String
          attribute :xrefs, SparxElementXrefs
          attribute :tags, SparxElementTags
        end
      end
    end

    class SparxConnectorSource < Shale::Mapper
      include SparxConnectorEnd

      xml do
        root "source"

        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

        map_element "model", to: :model, render_nil: true
        map_element "role", to: :role, render_nil: true
        map_element "type", to: :type, render_nil: true
        map_element "constraints", to: :constraints, render_nil: true
        map_element "modifiers", to: :modifiers, render_nil: true
        map_element "style", to: :style, render_nil: true
        map_element "documentation", to: :documentation, render_nil: true
        map_element "xrefs", to: :xrefs, render_nil: true
        map_element "tags", to: :tags, render_nil: true
      end
    end

    class SparxConnectorTarget < Shale::Mapper
      include SparxConnectorEnd

      xml do
        root "target"

        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

        map_element "model", to: :model, render_nil: true
        map_element "role", to: :role, render_nil: true
        map_element "type", to: :type, render_nil: true
        map_element "constraints", to: :constraints, render_nil: true
        map_element "modifiers", to: :modifiers, render_nil: true
        map_element "style", to: :style, render_nil: true
        map_element "documentation", to: :documentation, render_nil: true
        map_element "xrefs", to: :xrefs, render_nil: true
        map_element "tags", to: :tags, render_nil: true
      end
    end

    class SparxConnectorProperties < Shale::Mapper
      attribute :ea_type, Shale::Type::String
      attribute :direction, Shale::Type::String

      xml do
        root "properties"

        map_attribute :ea_type, to: :ea_type
        map_attribute :direction, to: :direction
      end
    end

    class SparxConnectorAppearance < Shale::Mapper
      attribute :linemode, Shale::Type::Integer
      attribute :linecolor, Shale::Type::Integer
      attribute :linewidth, Shale::Type::Integer
      attribute :seqno, Shale::Type::Integer
      attribute :headStyle, Shale::Type::Integer
      attribute :lineStyle, Shale::Type::Integer

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

    class SparxConnector < Shale::Mapper
      attribute :idref, Shale::Type::String
      attribute :source, SparxConnectorSource
      attribute :target, SparxConnectorTarget
      attribute :model, SparxConnectorModel
      attribute :properties, SparxConnectorProperties
      attribute :documentation, Shale::Type::String
      attribute :appearance, SparxConnectorAppearance
      attribute :labels, Shale::Type::String
      attribute :extended_properties, SparxElementExtendedProperties
      attribute :style, SparxElementStyle
      attribute :tags, SparxElementTags
      attribute :xrefs, SparxElementXrefs

      xml do
        root "element"

        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

        map_element "source", to: :source
        map_element "target", to: :target
        map_element "model", to: :model
        map_element "properties", to: :properties
        map_element "documentation", to: :documentation, render_nil: true
        map_element "appearance", to: :appearance
        map_element "labels", to: :labels, render_nil: true
        map_element "extendedProperties", to: :extended_properties
        map_element "style", to: :style, render_nil: true
        map_element "xrefs", to: :xrefs, render_nil: true
        map_element "tags", to: :tags, render_nil: true
      end
    end

    class SparxConnectors < Shale::Mapper
      attribute :connector, SparxConnector, collection: true
      xml do
        root "connectors"

        map_element "connector", to: :connector
      end
    end

    class SparxPrimitiveTypes < Shale::Mapper
      attribute :packaged_element, Uml::PackagedElement, collection: true

      xml do
        root "primitivetypes"

        map_element "packagedElement", to: :packaged_element
      end
    end

    class SparxProfiles < Shale::Mapper
      attribute :profile, Uml::Profile, collection: true

      xml do
        root "profiles"

        map_element "Profile", to: :profile,
          namespace: "http://www.omg.org/spec/UML/20161101",
          prefix: "uml"
      end
    end

    class SparxProfiles2013 < Shale::Mapper
      attribute :profile, Uml::Profile2013, collection: true

      xml do
        root "profiles"

        map_element "Profile", to: :profile,
          namespace: "http://www.omg.org/spec/UML/20131001",
          prefix: "uml"
      end
    end


    class SparxDiagramElement < Shale::Mapper
      attribute :geometry, Shale::Type::String
      attribute :subject, Shale::Type::String
      attribute :seqno, Shale::Type::Integer
      attribute :style, Shale::Type::String

      xml do
        root "element"

        map_attribute "geometry", to: :geometry
        map_attribute "subject", to: :subject
        map_attribute "seqno", to: :seqno
        map_attribute "style", to: :style
      end
    end

    class SparxDiagramElements < Shale::Mapper
      attribute :element, SparxDiagramElement, collection: true
      xml do
        root "elements"

        map_element "element", to: :element
      end
    end

    class SparxDiagramModel < Shale::Mapper
      attribute :package, Shale::Type::String
      attribute :local_id, Shale::Type::String
      attribute :owner, Shale::Type::String

      xml do
        root "model"

        map_attribute "package", to: :package
        map_attribute "localID", to: :local_id
        map_attribute "owner", to: :owner
      end
    end

    class SparxDiagramStyle < Shale::Mapper
      attribute :value, SparxDiagramElement

      xml do
        map_attribute "value", to: :value
      end
    end

    class SparxDiagram < Shale::Mapper
      attribute :id, Shale::Type::String
      attribute :model, SparxDiagramModel
      attribute :properties, SparxElementProperties
      attribute :project, SparxElementProject
      attribute :style1, SparxDiagramStyle
      attribute :style2, SparxDiagramStyle
      attribute :swimlanes, SparxDiagramStyle
      attribute :matrixitems, SparxDiagramStyle
      attribute :extended_properties, SparxElementExtendedProperties
      attribute :xrefs, SparxElementXrefs
      attribute :elements, SparxDiagramElements

      xml do
        root "diagram"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

        map_element "model", to: :model
        map_element "properties", to: :properties
        map_element "project", to: :project
        map_element "style1", to: :style1, render_nil: true
        map_element "style2", to: :style2, render_nil: true
        map_element "swimlanes", to: :swimlanes, render_nil: true
        map_element "matrixitems", to: :matrixitems, render_nil: true
        map_element "extendedProperties", to: :extended_properties, render_nil: true
        map_element "xrefs", to: :xrefs, render_nil: true
        map_element "elements", to: :elements
      end
    end

    class SparxDiagrams < Shale::Mapper
      attribute :diagram, SparxDiagram, collection: true

      xml do
        root "diagrams"

        map_element "diagram", to: :diagram
      end
    end

    module SparxExtensionAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :id, Shale::Type::String
          attribute :label, Shale::Type::String
          attribute :uuid, Shale::Type::String
          attribute :href, Shale::Type::String
          attribute :idref, Shale::Type::String
          attribute :type, Shale::Type::String
          attribute :extender, Shale::Type::String
          attribute :extender_id, Shale::Type::String
          attribute :elements, SparxElements
          attribute :connectors, SparxConnectors
          attribute :primitive_types, SparxPrimitiveTypes
          attribute :diagrams, SparxDiagrams
        end
      end
    end

    class SparxExtension < Shale::Mapper
      include SparxExtensionAttributes
      attribute :profiles, SparxProfiles

      xml do
        root "Extension"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "label", to: :label, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "uuid", to: :uuid, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "href", to: :href
        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "type", to: :type, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "extender", to: :extender
        map_attribute "extenderID", to: :extender_id

        map_element "elements", to: :elements
        map_element "connectors", to: :connectors
        map_element "primitivetypes", to: :primitive_types
        map_element "profiles", to: :profiles
        map_element "diagrams", to: :diagrams
      end
    end

    class SparxExtension2013 < Shale::Mapper
      include SparxExtensionAttributes
      attribute :profiles, SparxProfiles2013

      xml do
        root "Extension"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "label", to: :label, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "uuid", to: :uuid, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "href", to: :href
        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "type", to: :type, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "extender", to: :extender
        map_attribute "extenderID", to: :extender_id

        map_element "elements", to: :elements
        map_element "connectors", to: :connectors
        map_element "primitivetypes", to: :primitive_types
        map_element "profiles", to: :profiles
        map_element "diagrams", to: :diagrams
      end
    end

    class SparxSysPhS < Shale::Mapper
      attribute :base_package, Shale::Type::String
      attribute :name, Shale::Type::String

      xml do
        root "ModelicaParameter"
        namespace "http://www.sparxsystems.com/profiles/SysPhS/1.0", "SysPhS"

        map_attribute "base_Package", to: :base_package
        map_attribute "name", to: :name
      end
    end

    class SparxCustomProfilePublicationDate < Shale::Mapper
      attribute :base_package, Shale::Type::String
      attribute :publication_date, Shale::Type::String

      xml do
        root "publicationDate"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Package", to: :base_package
        map_attribute "publicationDate", to: :publication_date
      end
    end

    class SparxCustomProfileEdition < Shale::Mapper
      attribute :base_package, Shale::Type::String
      attribute :edition, Shale::Type::String

      xml do
        root "edition"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Package", to: :base_package
        map_attribute "edition", to: :edition
      end
    end

    class SparxCustomProfileNumber < Shale::Mapper
      attribute :base_package, Shale::Type::String
      attribute :number, Shale::Type::String

      xml do
        root "number"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Package", to: :base_package
        map_attribute "number", to: :number
      end
    end

    class SparxCustomProfileYearVersion < Shale::Mapper
      attribute :base_package, Shale::Type::String
      attribute :year_version, Shale::Type::String

      xml do
        root "yearVersion"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Package", to: :base_package
        map_attribute "yearVersion", to: :year_version
      end
    end

    module SparxRootAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :publication_date, SparxCustomProfilePublicationDate
          attribute :edition, SparxCustomProfileEdition
          attribute :number, SparxCustomProfileNumber
          attribute :year_version, SparxCustomProfileYearVersion
          attribute :modelica_parameter, SparxSysPhS
        end
      end
    end

    class SparxRoot < Root
      include SparxRootAttributes
      attribute :extension, SparxExtension

      @@default_mapping =<<-MAP
      root "XMI"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmi"

      map_attribute "id", to: :id
      map_attribute "label", to: :label
      map_attribute "uuid", to: :uuid
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref
      map_attribute "type", to: :type

      map_element "Extension", to: :extension
      map_element "publicationDate", to: :publication_date,
                                     namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                                     prefix: "thecustomprofile"
      map_element "edition", to: :edition,
                             namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                             prefix: "thecustomprofile"
      map_element "number", to: :number,
                            namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                            prefix: "thecustomprofile"
      map_element "yearVersion", to: :year_version,
                                 namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                                 prefix: "thecustomprofile"
      map_element "ModelicaParameter", to: :modelica_parameter,
                                       namespace: "http://www.sparxsystems.com/profiles/SysPhS/1.0",
                                       prefix: "SysPhS"
      MAP

      @@mapping ||= @@default_mapping

      xml do
        eval Xmi::Sparx::SparxRoot.class_variable_get("@@mapping")
      end
    end

    class SparxRoot2013 < Root2013
      include SparxRootAttributes
      attribute :extension, SparxExtension2013

      @@default_mapping =<<-MAP
      root "XMI"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmi"

      map_attribute "id", to: :id
      map_attribute "label", to: :label
      map_attribute "uuid", to: :uuid
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref
      map_attribute "type", to: :type

      map_element "Extension", to: :extension
      map_element "publicationDate", to: :publication_date,
                                     namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                                     prefix: "thecustomprofile"
      map_element "edition", to: :edition,
                             namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                             prefix: "thecustomprofile"
      map_element "number", to: :number,
                            namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                            prefix: "thecustomprofile"
      map_element "yearVersion", to: :year_version,
                                 namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                                 prefix: "thecustomprofile"
      map_element "ModelicaParameter", to: :modelica_parameter,
                                       namespace: "http://www.sparxsystems.com/profiles/SysPhS/1.0",
                                       prefix: "SysPhS"
      MAP

      @@mapping ||= @@default_mapping

      xml do
        eval Xmi::Sparx::SparxRoot2013.class_variable_get("@@mapping")
      end
    end
  end
end
