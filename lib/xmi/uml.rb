# frozen_string_literal: true

module Xmi
  module Uml
    class AnnotatedElement < Shale::Mapper
      attribute :idref, Shale::Type::String

      xml do
        root "annotatedElement"

        map_attribute "idref", to: :idref, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
      end
    end

    class Type < Shale::Mapper
      attribute :idref, Shale::Type::String
      attribute :href, Shale::Type::String

      xml do
        root "type"

        map_attribute "idref", to: :idref, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "href", to: :href
      end
    end

    class MemberEnd < Shale::Mapper
      attribute :idref, Shale::Type::String

      xml do
        root "memberEnd"

        map_attribute "idref", to: :idref, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
      end
    end

    module OwnedEndAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :type, Shale::Type::String
          attribute :id, Shale::Type::String
          attribute :association, Shale::Type::String
          attribute :name, Shale::Type::String
          attribute :uml_type, Uml::Type
          attribute :member_end, MemberEnd
          attribute :lower, Shale::Type::Integer
          attribute :upper, Shale::Type::Integer
          attribute :is_composite, Shale::Type::Boolean
        end
      end
    end

    class OwnedEnd < Shale::Mapper
      include OwnedEndAttributes

      xml do
        root "ownedEnd"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "memberEnd", to: :member_end
        map_attribute "type", to: :uml_type
        map_attribute "lower", to: :lower
        map_attribute "upper", to: :upper
        map_attribute "isComposite", to: :is_composite
      end
    end

    class OwnedEnd2013 < Shale::Mapper
      include OwnedEndAttributes

      xml do
        root "ownedEnd"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "memberEnd", to: :member_end
        map_attribute "type", to: :uml_type
        map_attribute "lower", to: :lower
        map_attribute "upper", to: :upper
        map_attribute "isComposite", to: :is_composite
      end
    end

    class DefaultValue < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :id, Shale::Type::String
      attribute :value, Shale::Type::String

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

    class OwnedLiteral < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :id, Shale::Type::String
      attribute :name, Shale::Type::String

      xml do
        root "ownedLiteral"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :value
      end
    end

    module OwnedAttributeAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :type, Shale::Type::String
          attribute :id, Shale::Type::String
          attribute :association, Shale::Type::String
          attribute :name, Shale::Type::String
          attribute :is_derived, Shale::Type::String
          attribute :uml_type, Uml::Type
          attribute :upper_value, UpperValue
          attribute :lower_value, LowerValue
        end
      end
    end

    class OwnedAttribute < Shale::Mapper
      include OwnedAttributeAttributes

      xml do
        root "ownedAttribute"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "isDerived", to: :is_derived

        map_element "type", to: :uml_type
        map_element "upperValue", to: :upper_value
        map_element "lowerValue", to: :lower_value
      end
    end

    class OwnedAttribute2013 < Shale::Mapper
      include OwnedAttributeAttributes

      xml do
        root "ownedAttribute"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "isDerived", to: :is_derived

        map_element "type", to: :uml_type
        map_element "upperValue", to: :upper_value
        map_element "lowerValue", to: :lower_value
      end
    end

    class OwnedParameter < Shale::Mapper
      attribute :id, Shale::Type::String
      attribute :name, Shale::Type::String
      attribute :type, Shale::Type::String
      attribute :direction, Shale::Type::String
      attribute :upper_value, UpperValue
      attribute :lower_value, LowerValue
      attribute :default_value, DefaultValue

      xml do
        root "ownedParameter"

        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name
        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "direction", to: :direction

        map_element "upperValue", to: :upper_value
        map_element "lowerValue", to: :lower_value
        map_element "defaultValue", to: :default_value
      end
    end

    class Specification < Shale::Mapper
      attribute :id, Shale::Type::String
      attribute :type, Shale::Type::String
      attribute :language, Shale::Type::String

      xml do
        root "specification"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "language", to: :language
      end
    end

    class Precondition < Shale::Mapper
      attribute :id, Shale::Type::String
      attribute :name, Shale::Type::String
      attribute :type, Shale::Type::String
      attribute :specification, Specification

      xml do
        root "precondition"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name
        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_element "specification", to: :specification
      end
    end

    class OwnedOperation < Shale::Mapper
      attribute :id, Shale::Type::String
      attribute :name, Shale::Type::String
      attribute :owned_parameter, OwnedParameter, collection: true
      attribute :precondition, Precondition
      attribute :uml_type, Uml::Type, collection: true

      xml do
        root "ownedOperation"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name
        map_element "ownedParameter", to: :owned_parameter
        map_element "precondition", to: :precondition
        map_element "type", to: :uml_type
      end
    end

    module OwnedCommentAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :type, Shale::Type::String
          attribute :id, Shale::Type::String
          attribute :body_element, Shale::Type::String
          attribute :body_attribute, Shale::Type::String
          attribute :annotated_attribute, Shale::Type::String
          attribute :annotated_element, AnnotatedElement
        end
      end
    end

    class OwnedComment < Shale::Mapper
      include OwnedCommentAttributes

      xml do
        root "ownedComment"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_attribute "name", to: :name
        map_attribute "body", to: :body_attribute
        map_attribute "annotatedElement", to: :annotated_attribute

        map_element "annotatedElement", to: :annotated_element, prefix: nil, namespace: nil
        map_element "body", to: :body_element
      end
    end

    class OwnedComment2013 < Shale::Mapper
      include OwnedCommentAttributes

      xml do
        root "ownedComment"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name
        map_attribute "body", to: :body_attribute
        map_attribute "annotatedElement", to: :annotated_attribute

        map_element "annotatedElement", to: :annotated_element, prefix: nil, namespace: nil
        map_element "body", to: :body_element
      end
    end

    module AssociationGeneralizationAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :type, Shale::Type::String
          attribute :id, Shale::Type::String
          attribute :general, Shale::Type::String
        end
      end
    end

    class AssociationGeneralization < Shale::Mapper
      include AssociationGeneralizationAttributes

      xml do
        root "generalization"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_attribute "general", to: :general
      end
    end

    class AssociationGeneralization2013 < Shale::Mapper
      include AssociationGeneralizationAttributes

      xml do
        root "generalization"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "general", to: :general
      end
    end

    module PackagedElementAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :type, Shale::Type::String
          attribute :id, Shale::Type::String
          attribute :name, Shale::Type::String
          attribute :member_end, MemberEnd
          attribute :owned_literal, OwnedLiteral, collection: true
          attribute :owned_operation, OwnedOperation, collection: true

          # EA specific
          attribute :supplier, Shale::Type::String
          attribute :client, Shale::Type::String
        end
      end
    end

    class PackagedElement < Shale::Mapper
      include PackagedElementAttributes
      attribute :packaged_element, PackagedElement, collection: true
      attribute :owned_end, OwnedEnd, collection: true
      attribute :owned_attribute, OwnedAttribute, collection: true
      attribute :owned_comment, OwnedComment, collection: true
      attribute :generalization, AssociationGeneralization, collection: true

      xml do
        root "packagedElement"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name
        map_attribute "memberEnd", to: :member_end

        # EA specific
        map_attribute "supplier", to: :supplier
        map_attribute "client", to: :client

        map_element "generalization", to: :generalization
        map_element "ownedComment", to: :owned_comment
        map_element "ownedEnd", to: :owned_end
        map_element "ownedLiteral", to: :owned_literal
        map_element "ownedAttribute", to: :owned_attribute
        map_element "ownedOperation", to: :owned_operation
        map_element "packagedElement", to: :packaged_element
      end
    end

    class PackagedElement2013 < Shale::Mapper
      include PackagedElementAttributes
      attribute :packaged_element, PackagedElement2013, collection: true
      attribute :owned_end, OwnedEnd2013, collection: true
      attribute :owned_attribute, OwnedAttribute2013, collection: true
      attribute :owned_comment, OwnedComment2013, collection: true
      attribute :generalization, AssociationGeneralization2013, collection: true

      xml do
        root "packagedElement"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name
        map_attribute "memberEnd", to: :member_end

        # EA specific
        map_attribute "supplier", to: :supplier
        map_attribute "client", to: :client

        map_element "generalization", to: :generalization
        map_element "ownedComment", to: :owned_comment
        map_element "ownedEnd", to: :owned_end
        map_element "ownedLiteral", to: :owned_literal
        map_element "ownedAttribute", to: :owned_attribute
        map_element "ownedOperation", to: :owned_operation
        map_element "packagedElement", to: :packaged_element
      end
    end

    class Bounds < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :id, Shale::Type::String
      attribute :x, Shale::Type::Integer
      attribute :y, Shale::Type::Integer
      attribute :height, Shale::Type::Integer
      attribute :width, Shale::Type::Integer

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

    class Waypoint < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :id, Shale::Type::String
      attribute :x, Shale::Type::Integer
      attribute :y, Shale::Type::Integer

      xml do
        root "waypoint"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "x", to: :x
        map_attribute "y", to: :y
      end
    end

    class OwnedElement < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :id, Shale::Type::String
      attribute :text, Shale::Type::String
      attribute :model_element, Shale::Type::String
      attribute :owned_element, OwnedElement, collection: true
      attribute :bounds, Bounds, collection: true
      attribute :source, Shale::Type::String
      attribute :target, Shale::Type::String
      attribute :waypoint, Waypoint

      xml do
        root "ownedElement"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "modelElement", to: :model_element

        map_element "ownedElement", to: :owned_element
        map_element "bounds", to: :bounds
        map_element "source", to: :source
        map_element "target", to: :target
        map_element "waypoint", to: :waypoint
      end
    end

    module DiagramAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :type, Shale::Type::String
          attribute :id, Shale::Type::String
          attribute :is_frame, Shale::Type::Boolean
          attribute :model_element, Shale::Type::String
          attribute :owned_element, OwnedElement, collection: true
        end
      end
    end

    class Diagram < Shale::Mapper
      include DiagramAttributes

      xml do
        root "Diagram"
        namespace "http://www.omg.org/spec/UML/20161101/UMLDI", "umldi"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "isFrame", to: :is_frame
        map_attribute "modelElement", to: :model_element

        map_element "ownedElement", to: :owned_element, namespace: nil, prefix: nil
      end
    end

    class Diagram2013 < Shale::Mapper
      include DiagramAttributes

      xml do
        root "Diagram"
        namespace "http://www.omg.org/spec/UML/20131001/UMLDI", "umldi"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "isFrame", to: :is_frame
        map_attribute "modelElement", to: :model_element

        map_element "ownedElement", to: :owned_element, namespace: nil, prefix: nil
      end
    end

    class ProfileApplicationAppliedProfile < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :href, Shale::Type::String

      xml do
        root "appliedProfile"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "href", to: :href
      end
    end

    class ProfileApplication < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :id, Shale::Type::String
      attribute :applied_profile, ProfileApplicationAppliedProfile

      xml do
        root "profileApplication"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"

        map_element "appliedProfile", to: :applied_profile
      end
    end

    class ImportedPackage < Shale::Mapper
      attribute :href, Shale::Type::String

      xml do
        root "importedPackage"

        map_attribute "href", to: :href, namespace: nil, prefix: nil
      end
    end

    module PackageImportAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :id, Shale::Type::String
          attribute :imported_package, ImportedPackage
        end
      end
    end

    class PackageImport < Shale::Mapper
      include PackageImportAttributes

      xml do
        root "packageImport"

        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"

        map_element "importedPackage", to: :imported_package, namespace: nil, prefix: nil
      end
    end

    class PackageImport2013 < Shale::Mapper
      include PackageImportAttributes

      xml do
        root "packageImport"

        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"

        map_element "importedPackage", to: :imported_package, namespace: nil, prefix: nil
      end
    end

    module UmlModelAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :type, Shale::Type::String
          attribute :name, Shale::Type::String
          attribute :profile_application, ProfileApplication, collection: true
        end
      end
    end

    class UmlModel < Shale::Mapper
      include UmlModelAttributes
      attribute :packaged_element, PackagedElement, collection: true
      attribute :package_import, PackageImport, collection: true
      attribute :diagram, Diagram

      xml do
        root "Model"
        namespace "http://www.omg.org/spec/UML/20161101", "uml"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name

        map_element "packageImport", to: :package_import, namespace: nil, prefix: nil
        map_element "packagedElement", to: :packaged_element, namespace: nil, prefix: nil
        map_element "Diagram", to: :diagram, namespace: "http://www.omg.org/spec/UML/20161101/UMLDI", prefix: "umldi"
        map_element "profileApplication", to: :profile_application, namespace: nil, prefix: nil
      end
    end

    class UmlModel2013 < Shale::Mapper
      include UmlModelAttributes
      attribute :packaged_element, PackagedElement2013, collection: true
      attribute :package_import, PackageImport2013, collection: true
      attribute :diagram, Diagram2013

      xml do
        root "Model"
        namespace "http://www.omg.org/spec/UML/20161101", "uml"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name

        map_element "packageImport", to: :package_import, namespace: nil, prefix: nil
        map_element "packagedElement", to: :packaged_element, namespace: nil, prefix: nil
        map_element "Diagram", to: :diagram, namespace: "http://www.omg.org/spec/UML/20161101/UMLDI", prefix: "umldi"
        map_element "profileApplication", to: :profile_application, namespace: nil, prefix: nil
      end
    end

    module ProfileAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :packaged_element, PackagedElement, collection: true
          attribute :package_import, PackageImport, collection: true
          attribute :id, Shale::Type::String
          attribute :name, Shale::Type::String
          attribute :ns_prefix, Shale::Type::String

          # Is this an EA thing?
          attribute :metamodel_reference, Shale::Type::String
        end
      end
    end

    class Profile < Shale::Mapper
      include ProfileAttributes
      attribute :owned_comment, OwnedComment, collection: true

      xml do
        root "Profile"

        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_attribute "name", to: :name
        map_attribute "metamodelReference", to: :metamodel_reference
        map_attribute "nsPrefix", to: :ns_prefix

        map_element 'ownedComment', to: :owned_comment
        map_element "packageImport", to: :package_import, namespace: nil, prefix: nil
        map_element 'packagedElement', to: :packaged_element
      end
    end

    class Profile2013 < Shale::Mapper
      include ProfileAttributes
      attribute :owned_comment, OwnedComment2013, collection: true

      xml do
        root "Profile"

        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "name", to: :name
        map_attribute "metamodelReference", to: :metamodel_reference
        map_attribute "nsPrefix", to: :ns_prefix

        map_element 'ownedComment', to: :owned_comment
        map_element "packageImport", to: :package_import, namespace: nil, prefix: nil
        map_element 'packagedElement', to: :packaged_element
      end
    end
  end
end
