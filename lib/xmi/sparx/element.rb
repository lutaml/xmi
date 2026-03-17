# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Documentation < Lutaml::Model::Serializable
        attribute :value, :string

        xml do
          root "documentation"

          map_attribute "value", to: :value
        end
      end

      class Model < Lutaml::Model::Serializable
        attribute :package, :string
        attribute :package2, :string
        attribute :tpos, :integer
        attribute :ea_localid, :string
        attribute :ea_eleType, :string

        xml do
          root "model"
          namespace ::Xmi::Namespace::Omg::Uml

          map_attribute "package", to: :package
          map_attribute "package2", to: :package2
          map_attribute "tpos", to: :tpos
          map_attribute "ea_localid", to: :ea_localid
          map_attribute "ea_eleType", to: :ea_eleType
        end
      end

      class Properties < Lutaml::Model::Serializable
        attribute :name, :string
        attribute :type, ::Xmi::Type::XmiType
        attribute :is_specification, :boolean
        attribute :is_root, :boolean
        attribute :is_leaf, :boolean
        attribute :is_abstract, :boolean
        attribute :is_active, :boolean
        attribute :s_type, :string
        attribute :n_type, :string
        attribute :scope, :string
        attribute :stereotype, :string
        attribute :alias, :string
        attribute :documentation, :string

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

      class Project < Lutaml::Model::Serializable
        attribute :author, :string
        attribute :version, :string
        attribute :phase, :string
        attribute :created, :string
        attribute :modified, :string
        attribute :complexity, :integer
        attribute :status, :string

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

      class Code < Lutaml::Model::Serializable
        attribute :gentype, :string
        attribute :product_name, :string

        xml do
          root "code"

          map_attribute "gentype", to: :gentype
          map_attribute "product_name", to: :product_name
        end
      end

      class Style < Lutaml::Model::Serializable
        attribute :appearance, :string

        xml do
          root "style"

          map_attribute "appearance", to: :appearance
        end
      end

      class Tag < Lutaml::Model::Serializable
        attribute :id, ::Xmi::Type::XmiId
        attribute :name, :string
        attribute :value, :string
        attribute :model_element, :string

        xml do
          root "tag"

          map_attribute "id", to: :id
          map_attribute "name", to: :name
          map_attribute "value", to: :value
          map_attribute "modelElement", to: :model_element
        end
      end

      class Tags < Lutaml::Model::Serializable
        attribute :tags, Tag, collection: true

        xml do
          root "tags"
          map_element "tag", to: :tags, value_map: VALUE_MAP
        end
      end

      class Xrefs < Lutaml::Model::Serializable
        attribute :value, :string

        xml do
          root "xrefs"

          map_attribute "value", to: :value
        end
      end

      class ExtendedProperties < Lutaml::Model::Serializable
        attribute :tagged, :string
        attribute :package_name, :string
        attribute :virtual_inheritance, :integer

        xml do
          root "extendedProperties"

          map_attribute "tagged", to: :tagged
          map_attribute "package_name", to: :package_name
          map_attribute "virtualInheritance", to: :virtual_inheritance
        end
      end

      class PackageProperties < Lutaml::Model::Serializable
        attribute :version, :string
        attribute :xmiver, :string
        attribute :tpos, :string

        xml do
          root "packagedproperties"

          map_attribute "version", to: :version
          map_attribute "xmiver", to: :xmiver
          map_attribute "tpos", to: :tpos
        end
      end

      class Paths < Lutaml::Model::Serializable
        attribute :xmlpath, :string

        xml do
          root "paths"

          map_attribute "xmlpath", to: :xmlpath
        end
      end

      class Times < Lutaml::Model::Serializable
        attribute :created, :string
        attribute :modified, :string
        attribute :last_load_date, :string
        attribute :last_save_date, :string

        xml do
          root "times"

          map_attribute "created", to: :created
          map_attribute "modified", to: :modified
          map_attribute "lastloaddate", to: :last_load_date
          map_attribute "lastsavedate", to: :last_save_date
        end
      end

      class Flags < Lutaml::Model::Serializable
        attribute :is_controlled, :integer
        attribute :is_protected, :integer
        attribute :batch_save, :integer
        attribute :batch_load, :integer
        attribute :used_td, :integer
        attribute :log_xml, :integer
        attribute :package_flags, :string

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

      class Association < Lutaml::Model::Serializable
        attribute :id, ::Xmi::Type::XmiId
        attribute :start, :string
        attribute :end, :string
        attribute :name, :string, default: -> { "Association" }

        xml do
          root "Association"

          map_attribute "id", to: :id
          map_attribute "start", to: :start
          map_attribute "end", to: :end
        end
      end

      class Generalization < Association
        attribute :name, :string, default: -> { "Generalization" }

        xml do
          root "Generalization"

          map_attribute "id", to: :id
          map_attribute "start", to: :start
          map_attribute "end", to: :end
        end
      end

      class Aggregation < Association
        attribute :name, :string, default: -> { "Aggregation" }

        xml do
          root "Aggregation"

          map_attribute "id", to: :id
          map_attribute "start", to: :start
          map_attribute "end", to: :end
        end
      end

      class NoteLink < Association
        attribute :name, :string, default: -> { "NoteLink" }

        xml do
          root "NoteLink"

          map_attribute "id", to: :id
          map_attribute "start", to: :start
          map_attribute "end", to: :end
        end
      end

      class Styleex < Lutaml::Model::Serializable
        attribute :value, :string

        xml do
          root "styleex"

          map_attribute "value", to: :value
        end
      end

      class Bounds < Lutaml::Model::Serializable
        attribute :lower, :integer
        attribute :upper, :integer

        xml do
          root "bounds"

          map_attribute "lower", to: :lower
          map_attribute "upper", to: :upper
        end
      end

      class Stereotype < Lutaml::Model::Serializable
        attribute :stereotype, :string

        xml do
          root "stereotype"

          map_attribute "stereotype", to: :stereotype
        end
      end

      class Containment < Lutaml::Model::Serializable
        attribute :containment, :string
        attribute :position, :integer

        xml do
          root "containment"

          map_attribute "containment", to: :containment
          map_attribute "position", to: :position
        end
      end

      class Coords < Lutaml::Model::Serializable
        attribute :ordered, :integer
        attribute :scale, :integer

        xml do
          root "coords"

          map_attribute "ordered", to: :ordered
          map_attribute "scale", to: :scale
        end
      end

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

      class Links < Lutaml::Model::Serializable
        attribute :association, Association, collection: true
        attribute :generalization, Generalization, collection: true
        attribute :note_link, NoteLink, collection: true

        xml do
          root "links"

          map_element "Association", to: :association, value_map: VALUE_MAP
          map_element "Generalization", to: :generalization, value_map: VALUE_MAP
          map_element "NoteLink", to: :note_link, value_map: VALUE_MAP
        end
      end

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
