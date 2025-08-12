# frozen_string_literal: true

module Xmi
  module Sparx
    class SparxElementDocumentation < Lutaml::Model::Serializable
      attribute :value, :string

      xml do
        root "documentation"

        map_attribute "value", to: :value
      end
    end

    class SparxElementModel < Lutaml::Model::Serializable
      attribute :package, :string
      attribute :package2, :string
      attribute :tpos, :integer
      attribute :ea_localid, :string
      attribute :ea_eleType, :string

      xml do
        root "model"

        map_attribute "package", to: :package
        map_attribute "package2", to: :package2
        map_attribute "tpos", to: :tpos
        map_attribute "ea_localid", to: :ea_localid
        map_attribute "ea_eleType", to: :ea_eleType
      end
    end

    class SparxElementProperties < Lutaml::Model::Serializable
      attribute :name, :string
      attribute :type, :string
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

    class SparxElementProject < Lutaml::Model::Serializable
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

    class SparxElementCode < Lutaml::Model::Serializable
      attribute :gentype, :string
      attribute :product_name, :string

      xml do
        root "code"

        map_attribute "gentype", to: :gentype
        map_attribute "product_name", to: :product_name
      end
    end

    class SparxElementStyle < Lutaml::Model::Serializable
      attribute :appearance, :string

      xml do
        root "style"

        map_attribute "appearance", to: :appearance
      end
    end

    class SparxElementTag < Lutaml::Model::Serializable
      attribute :id, :string
      attribute :name, :string
      attribute :value, :string
      attribute :model_element, :string

      xml do
        root "tag"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "name", to: :name
        map_attribute "value", to: :value
        map_attribute "modelElement", to: :model_element
      end
    end

    class SparxElementTags < Lutaml::Model::Serializable
      attribute :tags, SparxElementTag, collection: true

      xml do
        root "tags"
        map_element "tag", to: :tags, namespace: nil, prefix: nil,
                           value_map: {
                             from: {
                               nil: :empty,
                               empty: :empty,
                               omitted: :empty
                             },
                             to: {
                               nil: :empty,
                               empty: :empty,
                               omitted: :empty
                             }
                           }
      end
    end

    class SparxElementXrefs < Lutaml::Model::Serializable
      attribute :value, :string

      xml do
        root "xrefs"

        map_attribute "value", to: :value
      end
    end

    class SparxElementExtendedProperties < Lutaml::Model::Serializable
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

    class SparxElementPackageProperties < Lutaml::Model::Serializable
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

    class SparxElementPaths < Lutaml::Model::Serializable
      attribute :xmlpath, :string

      xml do
        root "paths"

        map_attribute "xmlpath", to: :xmlpath
      end
    end

    class SparxElementTimes < Lutaml::Model::Serializable
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

    class SparxElementFlags < Lutaml::Model::Serializable
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

    class SparxElementAssociation < Lutaml::Model::Serializable
      attribute :id, :string
      attribute :start, :string
      attribute :end, :string
      attribute :name, :string, default: -> { "Association" }

      xml do
        root "Association"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "start", to: :start
        map_attribute "end", to: :end
      end
    end

    class SparxElementGeneralization < SparxElementAssociation
      attribute :name, :string, default: -> { "Generalization" }

      xml do
        root "Generalization"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "start", to: :start
        map_attribute "end", to: :end
      end
    end

    class SparxElementAggregation < SparxElementAssociation
      attribute :name, :string, default: -> { "Aggregation" }

      xml do
        root "Aggregation"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "start", to: :start
        map_attribute "end", to: :end
      end
    end

    class SparxElementNoteLink < SparxElementAssociation
      attribute :name, :string, default: -> { "NoteLink" }

      xml do
        root "NoteLink"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "start", to: :start
        map_attribute "end", to: :end
      end
    end

    class SparxElementStyleex < Lutaml::Model::Serializable
      attribute :value, :string

      xml do
        root "styleex"

        map_attribute "value", to: :value
      end
    end

    class SparxElementBounds < Lutaml::Model::Serializable
      attribute :lower, :integer
      attribute :upper, :integer

      xml do
        root "bounds"

        map_attribute "lower", to: :lower
        map_attribute "upper", to: :upper
      end
    end

    class SparxElementStereotype < Lutaml::Model::Serializable
      attribute :stereotype, :string

      xml do
        root "stereotype"

        map_attribute "stereotype", to: :stereotype
      end
    end

    class SparxElementContainment < Lutaml::Model::Serializable
      attribute :containment, :string
      attribute :position, :integer

      xml do
        root "containment"

        map_attribute "containment", to: :containment
        map_attribute "position", to: :position
      end
    end

    class SparxElementCoords < Lutaml::Model::Serializable
      attribute :ordered, :integer
      attribute :scale, :integer

      xml do
        root "coords"

        map_attribute "ordered", to: :ordered
        map_attribute "scale", to: :scale
      end
    end

    class SparxElementAttribute < Lutaml::Model::Serializable
      attribute :idref, :string
      attribute :name, :string
      attribute :scope, :string
      attribute :initial, :string
      attribute :documentation, SparxElementDocumentation
      attribute :options, :string
      attribute :style, :string
      attribute :tags, :string, collection: true
      attribute :model, SparxElementModel
      attribute :properties, SparxElementProperties
      attribute :coords, SparxElementCoords
      attribute :containment, SparxElementContainment
      attribute :stereotype, SparxElementStereotype
      attribute :bounds, SparxElementBounds
      attribute :styleex, SparxElementStyleex
      attribute :xrefs, SparxElementXrefs

      xml do # rubocop:disable Metrics/BlockLength
        root "attribute"

        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "name", to: :name
        map_attribute "scope", to: :scope

        map_element "initial", to: :initial, namespace: nil, prefix: nil
        map_element "options", to: :options, namespace: nil, prefix: nil
        map_element "style", to: :style, namespace: nil, prefix: nil
        map_element "tags", to: :tags, namespace: nil, prefix: nil,
                            value_map: {
                              from: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              },
                              to: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              }
                            }
        map_element "documentation", to: :documentation, namespace: nil,
                                     prefix: nil
        map_element "model", to: :model, namespace: nil, prefix: nil
        map_element "properties", to: :properties, namespace: nil, prefix: nil
        map_element "coords", to: :coords, namespace: nil, prefix: nil
        map_element "containment", to: :containment, namespace: nil, prefix: nil
        map_element "stereotype", to: :stereotype, namespace: nil, prefix: nil
        map_element "bounds", to: :bounds, namespace: nil, prefix: nil
        map_element "styleex", to: :styleex, namespace: nil, prefix: nil
        map_element "xrefs", to: :xrefs, namespace: nil, prefix: nil
      end
    end

    class SparxElementAttributes < Lutaml::Model::Serializable
      attribute :attribute, SparxElementAttribute, collection: true

      xml do
        root "attributes"

        map_element "attribute", to: :attribute, namespace: nil, prefix: nil,
                                 value_map: {
                                   from: {
                                     nil: :empty,
                                     empty: :empty,
                                     omitted: :empty
                                   },
                                   to: {
                                     nil: :empty,
                                     empty: :empty,
                                     omitted: :empty
                                   }
                                 }
      end
    end

    class SparxElementLinks < Lutaml::Model::Serializable
      attribute :association, SparxElementAssociation, collection: true
      attribute :generalization, SparxElementGeneralization, collection: true
      attribute :note_link, SparxElementNoteLink, collection: true

      xml do # rubocop:disable Metrics/BlockLength
        root "links"

        map_element "Association", to: :association, namespace: nil,
                                   prefix: nil,
                                   value_map: {
                                     from: {
                                       nil: :empty,
                                       empty: :empty,
                                       omitted: :empty
                                     },
                                     to: {
                                       nil: :empty,
                                       empty: :empty,
                                       omitted: :empty
                                     }
                                   }
        map_element "Generalization", to: :generalization, namespace: nil,
                                      prefix: nil,
                                      value_map: {
                                        from: {
                                          nil: :empty,
                                          empty: :empty,
                                          omitted: :empty
                                        },
                                        to: {
                                          nil: :empty,
                                          empty: :empty,
                                          omitted: :empty
                                        }
                                      }
        map_element "NoteLink", to: :note_link, namespace: nil, prefix: nil,
                                value_map: {
                                  from: {
                                    nil: :empty,
                                    empty: :empty,
                                    omitted: :empty
                                  },
                                  to: {
                                    nil: :empty,
                                    empty: :empty,
                                    omitted: :empty
                                  }
                                }
      end
    end

    class SparxElement < Lutaml::Model::Serializable
      attribute :idref, :string
      attribute :type, :string
      attribute :name, :string
      attribute :scope, :string
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
      attribute :links, SparxElementLinks, collection: true
      attribute :attributes, SparxElementAttributes

      xml do
        root "element"

        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "type", to: :type, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "name", to: :name
        map_attribute "scope", to: :scope

        map_element "model", to: :model, namespace: nil, prefix: nil
        map_element "properties", to: :properties, namespace: nil, prefix: nil
        map_element "project", to: :project, namespace: nil, prefix: nil
        map_element "code", to: :code, namespace: nil, prefix: nil
        map_element "style", to: :style, namespace: nil, prefix: nil
        map_element "tags", to: :tags, namespace: nil, prefix: nil
        map_element "xrefs", to: :xrefs, namespace: nil, prefix: nil
        map_element "extendedProperties", to: :extended_properties, namespace: nil, prefix: nil
        map_element "packageproperties", to: :package_properties, namespace: nil, prefix: nil
        map_element "paths", to: :paths, namespace: nil, prefix: nil
        map_element "times", to: :times, namespace: nil, prefix: nil
        map_element "flags", to: :flags, namespace: nil, prefix: nil
        map_element "links", to: :links, namespace: nil, prefix: nil
        map_element "attributes", to: :attributes, namespace: nil, prefix: nil
      end
    end

    class SparxElements < Lutaml::Model::Serializable
      attribute :element, SparxElement, collection: true

      xml do
        root "elements"

        map_element "element", to: :element, namespace: nil, prefix: nil,
                               value_map: {
                                 from: {
                                   nil: :empty,
                                   empty: :empty,
                                   omitted: :empty
                                 },
                                 to: {
                                   nil: :empty,
                                   empty: :empty,
                                   omitted: :empty
                                 }
                               }
      end
    end

    class SparxConnectorModel < Lutaml::Model::Serializable
      attribute :ea_localid, :string
      attribute :type, :string
      attribute :name, :string

      xml do
        map_attribute "ea_localid", to: :ea_localid
        map_attribute "type", to: :type
        map_attribute "name", to: :name
      end
    end

    class SparxConnectorEndRole < Lutaml::Model::Serializable
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

    class SparxConnectorEndType < Lutaml::Model::Serializable
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

    class SparxConnectorEndModifiers < Lutaml::Model::Serializable
      attribute :is_ordered, :boolean
      attribute :is_navigable, :boolean

      xml do
        root "type"

        map_attribute "isOrdered", to: :is_ordered
        map_attribute "isNavigable", to: :is_navigable
      end
    end

    class SparxConnectorEndConstraint < Lutaml::Model::Serializable
      attribute :name, :string
      attribute :type, :string
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

    class SparxConnectorEndConstraints < Lutaml::Model::Serializable
      attribute :constraint, SparxConnectorEndConstraint, collection: true
      xml do
        root "constraints"

        map_element "constraint", to: :constraint, namespace: nil, prefix: nil,
                                  value_map: {
                                    from: {
                                      nil: :empty,
                                      empty: :empty,
                                      omitted: :empty
                                    },
                                    to: {
                                      nil: :empty,
                                      empty: :empty,
                                      omitted: :empty
                                    }
                                  }
      end
    end

    class SparxConnectorEndStyle < Lutaml::Model::Serializable
      attribute :value, :string

      xml do
        root "style"

        map_attribute "value", to: :value
      end
    end

    module SparxConnectorEnd
      def self.included(klass) # rubocop:disable Metrics/MethodLength
        klass.class_eval do
          attribute :idref, :string
          attribute :model, SparxConnectorModel
          attribute :role, SparxConnectorEndRole
          attribute :type, SparxConnectorEndType
          attribute :constraints, SparxConnectorEndConstraints
          attribute :modifiers, SparxConnectorEndModifiers
          attribute :style, SparxConnectorEndStyle
          attribute :documentation, SparxElementDocumentation
          attribute :xrefs, SparxElementXrefs
          attribute :tags, SparxElementTags
        end
      end
    end

    class SparxConnectorSource < Lutaml::Model::Serializable
      include SparxConnectorEnd

      xml do
        root "source"

        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

        map_element "model", to: :model, render_nil: true, namespace: nil, prefix: nil
        map_element "role", to: :role, render_nil: true, namespace: nil, prefix: nil
        map_element "type", to: :type, render_nil: true, namespace: nil, prefix: nil
        map_element "constraints", to: :constraints, render_nil: true, namespace: nil, prefix: nil
        map_element "modifiers", to: :modifiers, render_nil: true, namespace: nil, prefix: nil
        map_element "style", to: :style, render_nil: true, namespace: nil, prefix: nil
        map_element "documentation", to: :documentation, namespace: nil,
                                     prefix: nil,
                                     value_map: {
                                       from: {
                                         nil: :empty,
                                         empty: :empty,
                                         omitted: :empty
                                       },
                                       to: {
                                         nil: :empty,
                                         empty: :empty,
                                         omitted: :empty
                                       }
                                     }
        map_element "xrefs", to: :xrefs, render_nil: true, namespace: nil, prefix: nil
        map_element "tags", to: :tags, render_nil: true, namespace: nil, prefix: nil
      end
    end

    class SparxConnectorTarget < Lutaml::Model::Serializable
      include SparxConnectorEnd

      xml do
        root "target"

        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

        map_element "model", to: :model, render_nil: true, namespace: nil, prefix: nil
        map_element "role", to: :role, render_nil: true, namespace: nil, prefix: nil
        map_element "type", to: :type, render_nil: true, namespace: nil, prefix: nil
        map_element "constraints", to: :constraints, render_nil: true, namespace: nil, prefix: nil
        map_element "modifiers", to: :modifiers, render_nil: true, namespace: nil, prefix: nil
        map_element "style", to: :style, render_nil: true, namespace: nil, prefix: nil
        map_element "documentation", to: :documentation, prefix: nil,
                                     value_map: {
                                       from: {
                                         nil: :empty,
                                         empty: :empty,
                                         omitted: :empty
                                       },
                                       to: {
                                         nil: :empty,
                                         empty: :empty,
                                         omitted: :empty
                                       }
                                     }
        map_element "xrefs", to: :xrefs, render_nil: true, namespace: nil, prefix: nil
        map_element "tags", to: :tags, render_nil: true, namespace: nil, prefix: nil
      end
    end

    class SparxConnectorProperties < Lutaml::Model::Serializable
      attribute :ea_type, :string
      attribute :direction, :string

      xml do
        root "properties"

        map_attribute :ea_type, to: :ea_type
        map_attribute :direction, to: :direction
      end
    end

    class SparxConnectorAppearance < Lutaml::Model::Serializable
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

    class SparxConnectorLabels < Lutaml::Model::Serializable
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

    class SparxConnector < Lutaml::Model::Serializable
      attribute :name, :string
      attribute :idref, :string
      attribute :source, SparxConnectorSource
      attribute :target, SparxConnectorTarget
      attribute :model, SparxConnectorModel
      attribute :properties, SparxConnectorProperties
      attribute :documentation, SparxElementDocumentation
      attribute :appearance, SparxConnectorAppearance
      attribute :labels, SparxConnectorLabels
      attribute :extended_properties, SparxElementExtendedProperties
      attribute :style, SparxElementStyle
      attribute :tags, SparxElementTags
      attribute :xrefs, SparxElementXrefs

      xml do # rubocop:disable Metrics/BlockLength
        root "element"

        map_attribute "name", to: :name
        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

        map_element "source", to: :source, namespace: nil, prefix: nil
        map_element "target", to: :target, namespace: nil, prefix: nil
        map_element "model", to: :model, namespace: nil, prefix: nil
        map_element "properties", to: :properties, namespace: nil, prefix: nil
        map_element "documentation", to: :documentation, namespace: nil,
                                     prefix: nil,
                                     value_map: {
                                       from: {
                                         nil: :empty,
                                         empty: :empty,
                                         omitted: :empty
                                       },
                                       to: {
                                         nil: :empty,
                                         empty: :empty,
                                         omitted: :empty
                                       }
                                     }
        map_element "appearance", to: :appearance, namespace: nil, prefix: nil
        map_element "labels", to: :labels, render_nil: true, namespace: nil, prefix: nil
        map_element "extendedProperties", to: :extended_properties, namespace: nil, prefix: nil
        map_element "style", to: :style, render_nil: true, namespace: nil, prefix: nil
        map_element "xrefs", to: :xrefs, render_nil: true, namespace: nil, prefix: nil
        map_element "tags", to: :tags, render_nil: true, namespace: nil, prefix: nil
      end
    end

    class SparxConnectors < Lutaml::Model::Serializable
      attribute :connector, SparxConnector, collection: true
      xml do
        root "connectors"

        map_element "connector", to: :connector, namespace: nil, prefix: nil,
                                 value_map: {
                                   from: {
                                     nil: :empty,
                                     empty: :empty,
                                     omitted: :empty
                                   },
                                   to: {
                                     nil: :empty,
                                     empty: :empty,
                                     omitted: :empty
                                   }
                                 }
      end
    end

    class SparxPrimitiveTypes < Lutaml::Model::Serializable
      attribute :packaged_element, Uml::PackagedElement, collection: true

      xml do
        root "primitivetypes"

        map_element "packagedElement", to: :packaged_element, namespace: nil,
                                       prefix: nil,
                                       value_map: {
                                         from: {
                                           nil: :empty,
                                           empty: :empty,
                                           omitted: :empty
                                         },
                                         to: {
                                           nil: :empty,
                                           empty: :empty,
                                           omitted: :empty
                                         }
                                       }
      end
    end

    class SparxProfiles < Lutaml::Model::Serializable
      attribute :profile, Uml::Profile, collection: true

      xml do
        root "profiles"

        map_element "Profile", to: :profile,
                               namespace: "http://www.omg.org/spec/UML/20131001",
                               prefix: "uml",
                               value_map: {
                                 from: {
                                   nil: :empty,
                                   empty: :empty,
                                   omitted: :empty
                                 },
                                 to: {
                                   nil: :empty,
                                   empty: :empty,
                                   omitted: :empty
                                 }
                               }
      end
    end

    class SparxDiagramElement < Lutaml::Model::Serializable
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

    class SparxDiagramElements < Lutaml::Model::Serializable
      attribute :element, SparxDiagramElement, collection: true
      xml do
        root "elements"

        map_element "element", to: :element, namespace: nil, prefix: nil,
                               value_map: {
                                 from: {
                                   nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                 },
                                 to: {
                                   nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                 }
                               }
      end
    end

    class SparxDiagramModel < Lutaml::Model::Serializable
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

    class SparxDiagramStyle < Lutaml::Model::Serializable
      attribute :value, :string

      xml do
        map_attribute "value", to: :value
      end
    end

    class SparxDiagram < Lutaml::Model::Serializable
      attribute :id, :string
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

        map_element "model", to: :model, namespace: nil, prefix: nil
        map_element "properties", to: :properties, namespace: nil, prefix: nil
        map_element "project", to: :project, namespace: nil, prefix: nil
        map_element "style1", to: :style1, render_nil: true, namespace: nil, prefix: nil
        map_element "style2", to: :style2, render_nil: true, namespace: nil, prefix: nil
        map_element "swimlanes", to: :swimlanes, render_nil: true, namespace: nil, prefix: nil
        map_element "matrixitems", to: :matrixitems, render_nil: true, namespace: nil, prefix: nil
        map_element "extendedProperties", to: :extended_properties, render_nil: true, namespace: nil, prefix: nil
        map_element "xrefs", to: :xrefs, render_nil: true, namespace: nil, prefix: nil
        map_element "elements", to: :elements, namespace: nil, prefix: nil
      end
    end

    class SparxDiagrams < Lutaml::Model::Serializable
      attribute :diagram, SparxDiagram, collection: true

      xml do
        root "diagrams"

        map_element "diagram", to: :diagram, namespace: nil, prefix: nil,
                               value_map: {
                                 from: {
                                   nil: :empty,
                                   empty: :empty,
                                   omitted: :empty
                                 },
                                 to: {
                                   nil: :empty,
                                   empty: :empty,
                                   omitted: :empty
                                 }
                               }
      end
    end

    class SparxEAStub < Lutaml::Model::Serializable
      attribute :id, :string
      attribute :name, :string
      attribute :uml_type, :string

      xml do
        root "EAStub"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "name", to: :name, namespace: nil, prefix: nil
        map_attribute "UMLType", to: :uml_type, namespace: nil, prefix: nil
      end
    end

    module SparxExtensionAttributes
      def self.included(klass) # rubocop:disable Metrics/MethodLength
        klass.class_eval do
          attribute :id, :string
          attribute :label, :string
          attribute :uuid, :string
          attribute :href, :string
          attribute :idref, :string
          attribute :type, :string
          attribute :extender, :string
          attribute :extender_id, :string
          attribute :elements, SparxElements
          attribute :connectors, SparxConnectors
          attribute :primitive_types, SparxPrimitiveTypes
          attribute :diagrams, SparxDiagrams
          attribute :ea_stub, SparxEAStub, collection: true
        end
      end
    end

    class SparxExtension < Lutaml::Model::Serializable
      include SparxExtensionAttributes
      attribute :profiles, SparxProfiles

      xml do # rubocop:disable Metrics/BlockLength
        root "Extension"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "label", to: :label, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "uuid", to: :uuid, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "href", to: :href
        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "type", to: :type, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "extender", to: :extender
        map_attribute "extenderID", to: :extender_id

        map_element "elements", to: :elements, namespace: nil, prefix: nil
        map_element "connectors", to: :connectors, namespace: nil, prefix: nil
        map_element "primitivetypes", to: :primitive_types, namespace: nil, prefix: nil
        map_element "profiles", to: :profiles, namespace: nil, prefix: nil
        map_element "diagrams", to: :diagrams, namespace: nil, prefix: nil
        map_element "EAStub", to: :ea_stub, namespace: nil, prefix: nil,
                              value_map: {
                                from: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                },
                                to: {
                                  nil: :empty,
                                  empty: :empty,
                                  omitted: :empty
                                }
                              }
      end
    end

    class SparxSysPhS < Lutaml::Model::Serializable
      attribute :base_package, :string
      attribute :name, :string

      xml do
        root "ModelicaParameter"
        namespace "http://www.sparxsystems.com/profiles/SysPhS/1.0", "SysPhS"

        map_attribute "base_Package", to: :base_package
        map_attribute "name", to: :name
      end
    end

    class SparxCustomProfilePublicationDate < Lutaml::Model::Serializable
      attribute :base_package, :string
      attribute :publication_date, :string

      xml do
        root "publicationDate"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Package", to: :base_package
        map_attribute "publicationDate", to: :publication_date
      end
    end

    class SparxCustomProfileEdition < Lutaml::Model::Serializable
      attribute :base_package, :string
      attribute :edition, :string

      xml do
        root "edition"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Package", to: :base_package
        map_attribute "edition", to: :edition
      end
    end

    class SparxCustomProfileNumber < Lutaml::Model::Serializable
      attribute :base_package, :string
      attribute :number, :string

      xml do
        root "number"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Package", to: :base_package
        map_attribute "number", to: :number
      end
    end

    class SparxCustomProfileYearVersion < Lutaml::Model::Serializable
      attribute :base_package, :string
      attribute :year_version, :string

      xml do
        root "yearVersion"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"

        map_attribute "base_Package", to: :base_package
        map_attribute "yearVersion", to: :year_version
      end
    end

    module SparxRootAttributes
      def self.included(klass) # rubocop:disable Metrics/MethodLength
        klass.class_eval do
          attribute :publication_date, SparxCustomProfilePublicationDate
          attribute :edition, SparxCustomProfileEdition
          attribute :number, SparxCustomProfileNumber
          attribute :year_version, SparxCustomProfileYearVersion
          attribute :modelica_parameter, SparxSysPhS

          attribute :eauml_import, EaRoot::Eauml::Import, collection: true
          attribute :gml_application_schema, EaRoot::Gml::ApplicationSchema, collection: true
          attribute :gml_code_list, EaRoot::Gml::CodeList, collection: true
          attribute :gml_data_type, EaRoot::Gml::CodeList, collection: true
          attribute :gml_union, EaRoot::Gml::CodeList, collection: true
          attribute :gml_enumeration, EaRoot::Gml::CodeList, collection: true
          attribute :gml_type, EaRoot::Gml::CodeList, collection: true
          attribute :gml_feature_type, EaRoot::Gml::CodeList, collection: true
          attribute :gml_property, EaRoot::Gml::Property, collection: true
        end
      end
    end

    class SparxRoot < Root # rubocop:disable Metrics/ClassLength
      include SparxRootAttributes
      attribute :extension, SparxExtension
      attribute :model, Uml::UmlModel

      class << self
        def parse_xml(xml_content)
          xml_content = fix_encoding(xml_content)
          xml_content = replace_xmlns(xml_content)
          xml_content = replace_relative_ns(xml_content)
          xml_content = replace_ea_xmlns(xml_content)

          from_xml(xml_content)
        end

        private

        def fix_encoding(xml_content)
          return xml_content if xml_content.valid_encoding?

          xml_content
            .encode("UTF-16be", invalid: :replace, replace: "?")
            .encode("UTF-8")
        end

        def replace_xmlns(xml_content)
          xml_content
            .gsub(%r{xmlns:xmi="http://www.omg.org/spec/XMI/\d{8}},
                  "xmlns:xmi=\"http://www.omg.org/spec/XMI/20131001")
            .gsub(%r{xmlns:uml="http://www.omg.org/spec/UML/\d{8}},
                  "xmlns:uml=\"http://www.omg.org/spec/UML/20131001")
            .gsub(%r{xmlns:umldc="http://www.omg.org/spec/UML/\d{8}},
                  "xmlns:umldc=\"http://www.omg.org/spec/UML/20131001")
            .gsub(%r{xmlns:umldi="http://www.omg.org/spec/UML/\d{8}},
                  "xmlns:umldi=\"http://www.omg.org/spec/UML/20131001")
        end

        def replace_relative_ns(xml_content)
          xml_content.gsub(
            /<(.*)xmlns="(.*)" targetNamespace="(.*)"(.*)>/,
            '<\1xmlns="\3" targetNamespace="\3"\4>'
          )
        end

        def replace_ea_xmlns(xml_content)
          xml_content
            .gsub(
              /<GML:ApplicationSchema(.*)xmlns="(.*)"(.*)>/,
              '<GML:ApplicationSchema\1altered_xmlns="\2"\3>'
            )
            .gsub(
              /<CityGML:ApplicationSchema(.*)xmlns="(.*)"(.*)>/,
              '<CityGML:ApplicationSchema\1altered_xmlns="\2"\3>'
            )
        end
      end

      @@default_mapping = <<-MAP # rubocop:disable Style/ClassVars
      root "XMI"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmi"

      map_element "Extension", to: :extension,
                               namespace: "http://www.omg.org/spec/XMI/20131001",
                               prefix: "xmi"
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
      map_element "import", to: :eauml_import,
                            namespace: "http://www.sparxsystems.com/profiles/EAUML/1.0",
                            prefix: "EAUML",
                            value_map: {
                              from: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              },
                              to: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              }
                            }
      map_element "ApplicationSchema", to: :gml_application_schema,
                            namespace: "http://www.sparxsystems.com/profiles/GML/1.0",
                            prefix: "GML",
                            value_map: {
                              from: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              },
                              to: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              }
                            }
      map_element "CodeList", to: :gml_code_list,
                            namespace: "http://www.sparxsystems.com/profiles/GML/1.0",
                            prefix: "GML",
                            value_map: {
                              from: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              },
                              to: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              }
                            }
      map_element "DataType", to: :gml_data_type,
                            namespace: "http://www.sparxsystems.com/profiles/GML/1.0",
                            prefix: "GML",
                            value_map: {
                              from: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              },
                              to: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              }
                            }
      map_element "Union", to: :gml_union,
                            namespace: "http://www.sparxsystems.com/profiles/GML/1.0",
                            prefix: "GML",
                            value_map: {
                              from: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              },
                              to: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              }
                            }
      map_element "Enumeration", to: :gml_enumeration,
                            namespace: "http://www.sparxsystems.com/profiles/GML/1.0",
                            prefix: "GML",
                            value_map: {
                              from: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              },
                              to: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              }
                            }
      map_element "Type", to: :gml_type,
                            namespace: "http://www.sparxsystems.com/profiles/GML/1.0",
                            prefix: "GML",
                            value_map: {
                              from: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              },
                              to: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              }
                            }
      map_element "FeatureType", to: :gml_feature_type,
                            namespace: "http://www.sparxsystems.com/profiles/GML/1.0",
                            prefix: "GML",
                            value_map: {
                              from: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              },
                              to: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              }
                            }
      map_element "property", to: :gml_property,
                            namespace: "http://www.sparxsystems.com/profiles/GML/1.0",
                            prefix: "GML",
                            value_map: {
                              from: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              },
                              to: {
                                nil: :empty,
                                empty: :empty,
                                omitted: :empty
                              }
                            }

      map_element "Model", to: :model,
                           namespace: "http://www.omg.org/spec/UML/20131001",
                           prefix: "uml"
      MAP

      @@mapping ||= @@default_mapping # rubocop:disable Style/ClassVars

      xml do
        eval Xmi::Sparx::SparxRoot.class_variable_get("@@mapping") # rubocop:disable Security/Eval
      end
    end
  end
end
