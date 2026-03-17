# frozen_string_literal: true

module Xmi
  module Uml
    class AnnotatedElement < Lutaml::Model::Serializable
      attribute :idref, ::Xmi::Type::XmiIdRef

      xml do
        root "annotatedElement"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "idref", to: :idref
      end
    end

    class Type < Lutaml::Model::Serializable
      attribute :idref, ::Xmi::Type::XmiIdRef
      attribute :href, :string

      xml do
        root "type"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "idref", to: :idref
        map_attribute "href", to: :href
      end
    end

    class MemberEnd < Lutaml::Model::Serializable
      attribute :idref, ::Xmi::Type::XmiIdRef

      xml do
        root "memberEnd"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "idref", to: :idref
      end
    end

    class OwnedEnd < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :association, :string
      attribute :name, :string
      attribute :type_attr, :string
      attribute :uml_type, Uml::Type
      attribute :member_end, :string
      attribute :lower, :integer
      attribute :upper, :integer
      attribute :is_composite, :boolean

      xml do
        root "ownedEnd"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "memberEnd", to: :member_end
        map_attribute "type", to: :type_attr
        map_attribute "lower", to: :lower
        map_attribute "upper", to: :upper
        map_attribute "isComposite", to: :is_composite
        map_element "type", to: :uml_type
      end
    end

    class DefaultValue < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :value, :string

      xml do
        root "defaultValue"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "value", to: :value
      end
    end

    class UpperValue < DefaultValue
      xml do
        root "upperValue"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "value", to: :value
      end
    end

    class LowerValue < DefaultValue
      xml do
        root "lowerValue"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "value", to: :value
      end
    end

    class OwnedLiteral < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :uml_type, Uml::Type

      xml do
        root "ownedLiteral"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "name", to: :name

        map_element "type", to: :uml_type
      end
    end

    class OwnedAttribute < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :association, :string
      attribute :name, :string
      attribute :is_derived, :string
      attribute :uml_type, Uml::Type
      attribute :upper_value, UpperValue
      attribute :lower_value, LowerValue

      xml do
        root "ownedAttribute"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "isDerived", to: :is_derived

        map_element "type", to: :uml_type
        map_element "upperValue", to: :upper_value
        map_element "lowerValue", to: :lower_value
      end
    end

    class OwnedParameter < Lutaml::Model::Serializable
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :type, ::Xmi::Type::XmiType
      attribute :direction, :string
      attribute :upper_value, UpperValue
      attribute :lower_value, LowerValue
      attribute :default_value, DefaultValue

      xml do
        root "ownedParameter"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_attribute "type", to: :type
        map_attribute "direction", to: :direction

        map_element "upperValue", to: :upper_value
        map_element "lowerValue", to: :lower_value
        map_element "defaultValue", to: :default_value
      end
    end

    class Specification < Lutaml::Model::Serializable
      attribute :id, ::Xmi::Type::XmiId
      attribute :type, ::Xmi::Type::XmiType
      attribute :language, :string

      xml do
        root "specification"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "id", to: :id
        map_attribute "type", to: :type
        map_attribute "language", to: :language
      end
    end

    class Precondition < Lutaml::Model::Serializable
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :type, ::Xmi::Type::XmiType
      attribute :specification, Specification

      xml do
        root "precondition"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_attribute "type", to: :type
        map_element "specification", to: :specification
      end
    end

    class OwnedOperation < Lutaml::Model::Serializable
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :owned_parameter, OwnedParameter, collection: true
      attribute :precondition, Precondition
      attribute :uml_type, Uml::Type, collection: true

      xml do
        root "ownedOperation"
        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_element "ownedParameter", to: :owned_parameter,
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
        map_element "precondition", to: :precondition
        map_element "type", to: :uml_type,
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

    class OwnedComment < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :body_element, :string
      attribute :body_attribute, :string
      attribute :annotated_attribute, :string
      attribute :annotated_element, AnnotatedElement

      xml do
        root "ownedComment"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_attribute "body", to: :body_attribute
        map_attribute "annotatedElement", to: :annotated_attribute

        map_element "annotatedElement", to: :annotated_element
        map_element "body", to: :body_element
      end
    end

    class AssociationGeneralization < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :general, :string

      xml do
        root "generalization"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "general", to: :general
      end
    end

    class PackagedElement < Lutaml::Model::Serializable # rubocop:disable Metrics/ClassLength
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :member_end, :string
      attribute :member_ends, MemberEnd, collection: true
      attribute :owned_literal, OwnedLiteral, collection: true
      attribute :owned_operation, OwnedOperation, collection: true

      # EA specific
      attribute :supplier, :string
      attribute :client, :string

      attribute :packaged_element, PackagedElement, collection: true
      attribute :owned_end, OwnedEnd, collection: true
      attribute :owned_attribute, OwnedAttribute, collection: true
      attribute :owned_comment, OwnedComment, collection: true
      attribute :generalization, AssociationGeneralization, collection: true

      xml do # rubocop:disable Metrics/BlockLength
        root "packagedElement"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_attribute "memberEnd", to: :member_end

        # EA specific
        map_attribute "supplier", to: :supplier
        map_attribute "client", to: :client

        map_element "generalization", to: :generalization,
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
        map_element "ownedComment", to: :owned_comment,
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
        map_element "ownedEnd", to: :owned_end,
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
        map_element "ownedLiteral", to: :owned_literal,
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
        map_element "ownedAttribute", to: :owned_attribute,
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
        map_element "ownedOperation", to: :owned_operation,
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
        map_element "packagedElement", to: :packaged_element,
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
        map_element "memberEnd", to: :member_ends,
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
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :x, :integer
      attribute :y, :integer
      attribute :height, :integer
      attribute :width, :integer

      xml do
        root "bounds"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "x", to: :x
        map_attribute "y", to: :y
        map_attribute "height", to: :height
        map_attribute "width", to: :width
      end
    end

    class Waypoint < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :x, :integer
      attribute :y, :integer

      xml do
        root "waypoint"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "x", to: :x
        map_attribute "y", to: :y
      end
    end

    class OwnedElement < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :text, :string
      attribute :model_element, :string
      attribute :owned_element, OwnedElement, collection: true
      attribute :bounds, Bounds, collection: true
      attribute :source, :string
      attribute :target, :string
      attribute :waypoint, Waypoint

      xml do
        root "ownedElement"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "text", to: :text
        map_attribute "modelElement", to: :model_element

        map_element "ownedElement", to: :owned_element,
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
        map_element "bounds", to: :bounds,
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
        map_element "source", to: :source
        map_element "target", to: :target
        map_element "waypoint", to: :waypoint
      end
    end

    class Diagram < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :is_frame, :boolean
      attribute :model_element, :string
      attribute :owned_element, OwnedElement, collection: true

      xml do
        root "Diagram"
        namespace ::Xmi::Namespace::Omg::UmlDi

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "isFrame", to: :is_frame
        map_attribute "modelElement", to: :model_element

        map_element "ownedElement", to: :owned_element,
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
      attribute :type, ::Xmi::Type::XmiType
      attribute :href, :string

      xml do
        root "appliedProfile"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "href", to: :href
      end
    end

    class ProfileApplication < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :applied_profile, ProfileApplicationAppliedProfile

      xml do
        root "profileApplication"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id

        map_element "appliedProfile", to: :applied_profile
      end
    end

    class ImportedPackage < Lutaml::Model::Serializable
      attribute :href, :string

      xml do
        root "importedPackage"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "href", to: :href
      end
    end

    class PackageImport < Lutaml::Model::Serializable
      attribute :id, ::Xmi::Type::XmiId
      attribute :imported_package, ImportedPackage

      xml do
        root "packageImport"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "id", to: :id

        map_element "importedPackage", to: :imported_package
      end
    end

    class UmlModel < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :name, :string
      attribute :profile_application, ProfileApplication, collection: true
      attribute :packaged_element, PackagedElement, collection: true
      attribute :package_import, PackageImport, collection: true
      attribute :diagram, Diagram

      xml do
        root "Model"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "name", to: :name

        map_element "packageImport", to: :package_import,
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
        map_element "packagedElement", to: :packaged_element,
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
        map_element "Diagram", to: :diagram
        map_element "profileApplication", to: :profile_application,
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

    module ProfileAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :packaged_element, PackagedElement, collection: true
          attribute :package_import, PackageImport, collection: true
          attribute :id, ::Xmi::Type::XmiId
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

      xml do
        root "Profile"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_attribute "metamodelReference", to: :metamodel_reference
        map_attribute "nsPrefix", to: :ns_prefix

        map_element "ownedComment", to: :owned_comment,
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
        map_element "packageImport", to: :package_import,
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
        map_element "packagedElement", to: :packaged_element,
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
