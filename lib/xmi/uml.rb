# frozen_string_literal: true

module Xmi
  module Uml
    class AnnotatedElement < Lutaml::Model::Serializable
      attribute :idref, :string

      xml do
        root "annotatedElement"

        map_attribute "idref", to: :idref, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
      end
    end

    class Type < Lutaml::Model::Serializable
      attribute :idref, :string
      attribute :href, :string

      xml do
        root "type"

        map_attribute "idref", to: :idref, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "href", to: :href
      end
    end

    class MemberEnd < Lutaml::Model::Serializable
      attribute :idref, :string

      xml do
        root "memberEnd"

        map_attribute "idref", to: :idref, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
      end
    end

    module OwnedEndAttributes
      def self.included(klass) # rubocop:disable Metrics/MethodLength
        klass.class_eval do
          attribute :type, :string
          attribute :id, :string
          attribute :association, :string
          attribute :name, :string
          attribute :type_attr, :string
          attribute :uml_type, Uml::Type
          attribute :member_end, :string
          attribute :lower, :integer
          attribute :upper, :integer
          attribute :is_composite, :boolean
        end
      end
    end

    class OwnedEnd < Lutaml::Model::Serializable
      include OwnedEndAttributes

      xml do
        root "ownedEnd"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "memberEnd", to: :member_end
        map_attribute "type", to: :type_attr, namespace: nil, prefix: nil
        map_attribute "lower", to: :lower
        map_attribute "upper", to: :upper
        map_attribute "isComposite", to: :is_composite
        map_element "type", to: :uml_type, namespace: nil, prefix: nil
      end
    end

    class DefaultValue < Lutaml::Model::Serializable
      attribute :type, :string
      attribute :id, :string
      attribute :value, :string

      xml do
        root "defaultValue"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "value", to: :value
      end
    end

    class UpperValue < DefaultValue
      xml do
        root "upperValue"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "value", to: :value
      end
    end

    class LowerValue < DefaultValue
      xml do
        root "lowerValue"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "value", to: :value
      end
    end

    class OwnedLiteral < Lutaml::Model::Serializable
      attribute :type, :string
      attribute :id, :string
      attribute :name, :string
      attribute :uml_type, Uml::Type

      xml do
        root "ownedLiteral"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name

        map_element "type", to: :uml_type, namespace: nil, prefix: nil
      end
    end

    module OwnedAttributeAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :type, :string
          attribute :id, :string
          attribute :association, :string
          attribute :name, :string
          attribute :is_derived, :string
          attribute :uml_type, Uml::Type
          attribute :upper_value, UpperValue
          attribute :lower_value, LowerValue
        end
      end
    end

    class OwnedAttribute < Lutaml::Model::Serializable
      include OwnedAttributeAttributes

      xml do
        root "ownedAttribute"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "isDerived", to: :is_derived

        map_element "type", to: :uml_type, namespace: nil, prefix: nil
        map_element "upperValue", to: :upper_value, namespace: nil, prefix: nil
        map_element "lowerValue", to: :lower_value, namespace: nil, prefix: nil
      end
    end

    class OwnedParameter < Lutaml::Model::Serializable
      attribute :id, :string
      attribute :name, :string
      attribute :type, :string
      attribute :direction, :string
      attribute :upper_value, UpperValue
      attribute :lower_value, LowerValue
      attribute :default_value, DefaultValue

      xml do
        root "ownedParameter"

        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name
        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "direction", to: :direction

        map_element "upperValue", to: :upper_value, namespace: nil, prefix: nil
        map_element "lowerValue", to: :lower_value, namespace: nil, prefix: nil
        map_element "defaultValue", to: :default_value, namespace: nil, prefix: nil
      end
    end

    class Specification < Lutaml::Model::Serializable
      attribute :id, :string
      attribute :type, :string
      attribute :language, :string

      xml do
        root "specification"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "language", to: :language
      end
    end

    class Precondition < Lutaml::Model::Serializable
      attribute :id, :string
      attribute :name, :string
      attribute :type, :string
      attribute :specification, Specification

      xml do
        root "precondition"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name
        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_element "specification", to: :specification, namespace: nil, prefix: nil
      end
    end

    class OwnedOperation < Lutaml::Model::Serializable
      attribute :id, :string
      attribute :name, :string
      attribute :owned_parameter, OwnedParameter, collection: true
      attribute :precondition, Precondition
      attribute :uml_type, Uml::Type, collection: true

      xml do # rubocop:disable Metrics/BlockLength
        root "ownedOperation"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name
        map_element "ownedParameter", to: :owned_parameter, namespace: nil,
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
        map_element "precondition", to: :precondition, namespace: nil,
                                    prefix: nil
        map_element "type", to: :uml_type, namespace: nil, prefix: nil,
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

    module OwnedCommentAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :type, :string
          attribute :id, :string
          attribute :name, :string
          attribute :body_element, :string
          attribute :body_attribute, :string
          attribute :annotated_attribute, :string
          attribute :annotated_element, AnnotatedElement
        end
      end
    end

    class OwnedComment < Lutaml::Model::Serializable
      include OwnedCommentAttributes

      xml do
        root "ownedComment"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name
        map_attribute "body", to: :body_attribute
        map_attribute "annotatedElement", to: :annotated_attribute

        map_element "annotatedElement", to: :annotated_element, prefix: nil, namespace: nil
        map_element "body", to: :body_element, namespace: nil, prefix: nil
      end
    end

    module AssociationGeneralizationAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :type, :string
          attribute :id, :string
          attribute :general, :string
        end
      end
    end

    class AssociationGeneralization < Lutaml::Model::Serializable
      include AssociationGeneralizationAttributes

      xml do
        root "generalization"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "general", to: :general
      end
    end

    module PackagedElementAttributes
      def self.included(klass) # rubocop:disable Metrics/MethodLength
        klass.class_eval do
          attribute :type, :string
          attribute :id, :string
          attribute :name, :string
          attribute :member_end, :string
          attribute :member_ends, MemberEnd, collection: true
          attribute :owned_literal, OwnedLiteral, collection: true
          attribute :owned_operation, OwnedOperation, collection: true

          # EA specific
          attribute :supplier, :string
          attribute :client, :string
        end
      end
    end

    class PackagedElement < Lutaml::Model::Serializable # rubocop:disable Metrics/ClassLength
      include PackagedElementAttributes
      attribute :packaged_element, PackagedElement, collection: true
      attribute :owned_end, OwnedEnd, collection: true
      attribute :owned_attribute, OwnedAttribute, collection: true
      attribute :owned_comment, OwnedComment, collection: true
      attribute :generalization, AssociationGeneralization, collection: true

      xml do # rubocop:disable Metrics/BlockLength
        root "packagedElement"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name
        map_attribute "memberEnd", to: :member_end

        # EA specific
        map_attribute "supplier", to: :supplier
        map_attribute "client", to: :client

        map_element "generalization", to: :generalization, namespace: nil,
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
        map_element "ownedComment", to: :owned_comment, namespace: nil,
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
        map_element "ownedEnd", to: :owned_end, namespace: nil, prefix: nil,
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
        map_element "ownedLiteral", to: :owned_literal, namespace: nil,
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
        map_element "ownedAttribute", to: :owned_attribute, namespace: nil,
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
        map_element "ownedOperation", to: :owned_operation, namespace: nil,
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
        map_element "memberEnd", to: :member_ends, namespace: nil, prefix: nil,
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

    class Bounds < Lutaml::Model::Serializable
      attribute :type, :string
      attribute :id, :string
      attribute :x, :integer
      attribute :y, :integer
      attribute :height, :integer
      attribute :width, :integer

      xml do
        root "bounds"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "x", to: :x
        map_attribute "y", to: :y
        map_attribute "height", to: :height
        map_attribute "width", to: :width
      end
    end

    class Waypoint < Lutaml::Model::Serializable
      attribute :type, :string
      attribute :id, :string
      attribute :x, :integer
      attribute :y, :integer

      xml do
        root "waypoint"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "x", to: :x
        map_attribute "y", to: :y
      end
    end

    class OwnedElement < Lutaml::Model::Serializable
      attribute :type, :string
      attribute :id, :string
      attribute :text, :string
      attribute :model_element, :string
      attribute :owned_element, OwnedElement, collection: true
      attribute :bounds, Bounds, collection: true
      attribute :source, :string
      attribute :target, :string
      attribute :waypoint, Waypoint

      xml do # rubocop:disable Metrics/BlockLength
        root "ownedElement"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "text", to: :text
        map_attribute "modelElement", to: :model_element

        map_element "ownedElement", to: :owned_element, namespace: nil,
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
        map_element "bounds", to: :bounds, namespace: nil, prefix: nil,
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
        map_element "source", to: :source, namespace: nil, prefix: nil
        map_element "target", to: :target, namespace: nil, prefix: nil
        map_element "waypoint", to: :waypoint, namespace: nil, prefix: nil
      end
    end

    module DiagramAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :type, :string
          attribute :id, :string
          attribute :is_frame, :boolean
          attribute :model_element, :string
          attribute :owned_element, OwnedElement, collection: true
        end
      end
    end

    class Diagram < Lutaml::Model::Serializable
      include DiagramAttributes

      xml do
        root "Diagram"
        namespace "http://www.omg.org/spec/UML/20131001/UMLDI", "umldi"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "isFrame", to: :is_frame
        map_attribute "modelElement", to: :model_element

        map_element "ownedElement", to: :owned_element, namespace: nil,
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

    class ProfileApplicationAppliedProfile < Lutaml::Model::Serializable
      attribute :type, :string
      attribute :href, :string

      xml do
        root "appliedProfile"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "href", to: :href
      end
    end

    class ProfileApplication < Lutaml::Model::Serializable
      attribute :type, :string
      attribute :id, :string
      attribute :applied_profile, ProfileApplicationAppliedProfile

      xml do
        root "profileApplication"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"

        map_element "appliedProfile", to: :applied_profile, namespace: nil, prefix: nil
      end
    end

    class ImportedPackage < Lutaml::Model::Serializable
      attribute :href, :string

      xml do
        root "importedPackage"

        map_attribute "href", to: :href, namespace: nil, prefix: nil
      end
    end

    module PackageImportAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :id, :string
          attribute :imported_package, ImportedPackage
        end
      end
    end

    class PackageImport < Lutaml::Model::Serializable
      include PackageImportAttributes

      xml do
        root "packageImport"

        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"

        map_element "importedPackage", to: :imported_package, namespace: nil, prefix: nil
      end
    end

    module UmlModelAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :type, :string
          attribute :name, :string
          attribute :profile_application, ProfileApplication, collection: true
        end
      end
    end

    class UmlModel < Lutaml::Model::Serializable
      include UmlModelAttributes
      attribute :packaged_element, PackagedElement, collection: true
      attribute :package_import, PackageImport, collection: true
      attribute :diagram, Diagram

      xml do # rubocop:disable Metrics/BlockLength
        root "Model"
        namespace "http://www.omg.org/spec/UML/20131001", "uml"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name

        map_element "packageImport", to: :package_import, namespace: nil,
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
        map_element "Diagram", to: :diagram, namespace: "http://www.omg.org/spec/UML/20131001/UMLDI", prefix: "umldi"
        map_element "profileApplication", to: :profile_application,
                                          namespace: nil, prefix: nil,
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

    # TODO: add attributes xmlns:uml and xmlns:xmi
    module ProfileAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :packaged_element, PackagedElement, collection: true
          attribute :package_import, PackageImport, collection: true
          attribute :id, :string
          attribute :name, :string
          # attribute :xmi, :string
          # attribute :uml, :string
          attribute :ns_prefix, :string

          # Is this an EA thing?
          attribute :metamodel_reference, :string
        end
      end
    end

    class Profile < Lutaml::Model::Serializable
      include ProfileAttributes
      attribute :owned_comment, OwnedComment, collection: true

      xml do # rubocop:disable Metrics/BlockLength
        root "Profile"

        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name
        map_attribute "metamodelReference", to: :metamodel_reference
        map_attribute "nsPrefix", to: :ns_prefix

        map_element "ownedComment", to: :owned_comment, namespace: nil,
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
        map_element "packageImport", to: :package_import, namespace: nil,
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
  end
end
