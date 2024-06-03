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

    # <ownedEnd xmi:type="uml:ExtensionEnd" xmi:id="extension_PhSVariable" name="extension_PhSVariable" type="PhSVariable" isComposite="true" lower="0" upper="1" memberEnd="extension_PhSVariable PhSVariable-base_Part"/>
    class OwnedEnd < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :id, Shale::Type::String
      attribute :association, Shale::Type::String
      attribute :name, Shale::Type::String
      attribute :uml_type, Uml::Type
      attribute :member_end, MemberEnd
      attribute :lower, Shale::Type::Integer
      attribute :upper, Shale::Type::Integer
      attribute :is_composite, Shale::Type::Boolean

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

    class OwnedAttribute < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :id, Shale::Type::String
      attribute :association, Shale::Type::String
      attribute :name, Shale::Type::String
      attribute :is_derived, Shale::Type::String
      attribute :uml_type, Uml::Type
      attribute :upper_value, UpperValue
      attribute :lower_value, LowerValue

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

    class OwnedComment < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :id, Shale::Type::String
      attribute :body_element, Shale::Type::String
      attribute :body_attribute, Shale::Type::String
      attribute :annotated_attribute, Shale::Type::String
      attribute :annotated_element, AnnotatedElement

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


    # <generalization xmi:type="uml:Generalization" xmi:id="ModelicaParameter_PhSConstant_generalization" general="PhSConstant"/>
    class AssociationGeneralization < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :id, Shale::Type::String
      attribute :general, Shale::Type::String
      xml do
        root "generalization"
        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_attribute "general", to: :general
      end
    end

    class PackagedElement < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :id, Shale::Type::String
      attribute :name, Shale::Type::String
      attribute :member_end, MemberEnd
      attribute :owned_comment, OwnedComment, collection: true
      attribute :owned_literal, OwnedLiteral, collection: true
      attribute :owned_end, OwnedEnd, collection: true
      attribute :owned_attribute, OwnedAttribute, collection: true
      attribute :owned_operation, OwnedOperation, collection: true
      attribute :packaged_element, PackagedElement, collection: true
      attribute :generalization, AssociationGeneralization, collection: true

      # EA specific
      attribute :supplier, Shale::Type::String
      attribute :client, Shale::Type::String

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

    # <ownedElement xmi:type="umldi:UMLShape" xmi:id="EAID_C4D531A8_EF26_4b23_BE60_58B1C55534CE" modelElement="EAID_FB86C623_9125_4d6d_BE60_58B1C55534CE">
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

    class Diagram < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :id, Shale::Type::String
      attribute :is_frame, Shale::Type::Boolean
      attribute :model_element, Shale::Type::String
      attribute :owned_element, OwnedElement, collection: true

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

    class ProfileApplicationAppliedProfile < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :href, Shale::Type::String
      xml do
        root "appliedProfile"

        map_attribute "type", to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "href", to: :href
      end
    end

    # <profileApplication xmi:type="uml:ProfileApplication" xmi:id="profileap_thecustomprofile">
    #   <appliedProfile xmi:type="uml:Profile" href="http://www.sparxsystems.com/profiles/thecustomprofile/1.0#thecustomprofile"/>
    # </profileApplication>
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

    class PackageImport < Shale::Mapper
      attribute :id, Shale::Type::String
      attribute :imported_package, ImportedPackage

      xml do
        root "packageImport"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmi"
        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
        map_element "importedPackage", to: :imported_package, namespace: nil, prefix: nil
      end

    end

    class UmlModel < Shale::Mapper
      attribute :type, Shale::Type::String
      attribute :name, Shale::Type::String
      attribute :packaged_element, PackagedElement, collection: true
      attribute :package_import, PackageImport, collection: true
      attribute :diagram, Diagram
      attribute :profile_application, ProfileApplication, collection: true

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

    # <uml:Profile xmlns:uml="http://www.omg.org/spec/UML/20131001" xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmi:id="thecustomprofile" nsPrefix="thecustomprofile" name="thecustomprofile" metamodelReference="mmref01">
    #   <ownedComment xmi:type="uml:Comment" xmi:id="comment01" annotatedElement="thecustomprofile">
    #     <body> Version:1.0</body>
    #   </ownedComment>
    #   <packageImport xmi:id="mmref01">
    #     <importedPackage href="http://www.omg.org/spec/UML/20131001"/>
    #   </packageImport>
    #   <packagedElement xmi:type="uml:Stereotype" xmi:id="edition" name="edition">
    #     <ownedAttribute xmi:type="uml:Property" xmi:id="edition-base_Package" name="base_Package" association="Package_edition">
    #       <type href="http://www.omg.org/spec/UML/20131001/UML.xmi#Package"/>
    #     </ownedAttribute>
    #     <ownedAttribute xmi:type="uml:Property" xmi:id="edition-edition" name="edition">
    #       <type href="http://www.omg.org/spec/UML/20131001/UML.xmi#String"/>
    #     </ownedAttribute>
    #   </packagedElement>
    #   <packagedElement xmi:type="uml:Extension" xmi:id="Package_edition" name="A_Package_edition" memberEnd="extension_edition edition-base_Package">
    #     <ownedEnd xmi:type="uml:ExtensionEnd" xmi:id="extension_edition" name="extension_edition" type="edition" isComposite="true" lower="0" upper="1" memberEnd="extension_edition edition-base_Package"/>
    #   </packagedElement>
    #   <packagedElement xmi:type="uml:Stereotype" xmi:id="number" name="number">
    #     <ownedAttribute xmi:type="uml:Property" xmi:id="number-base_Package" name="base_Package" association="Package_number">
    #       <type href="http://www.omg.org/spec/UML/20131001/UML.xmi#Package"/>
    #     </ownedAttribute>
    #     <ownedAttribute xmi:type="uml:Property" xmi:id="number-number" name="number">
    #       <type href="http://www.omg.org/spec/UML/20131001/UML.xmi#String"/>
    #     </ownedAttribute>
    #   </packagedElement>
    #   <packagedElement xmi:type="uml:Extension" xmi:id="Package_number" name="A_Package_number" memberEnd="extension_number number-base_Package">
    #     <ownedEnd xmi:type="uml:ExtensionEnd" xmi:id="extension_number" name="extension_number" type="number" isComposite="true" lower="0" upper="1" memberEnd="extension_number number-base_Package"/>
    #   </packagedElement>
    #   <packagedElement xmi:type="uml:Stereotype" xmi:id="yearVersion" name="yearVersion">
    #     <ownedAttribute xmi:type="uml:Property" xmi:id="yearVersion-base_Package" name="base_Package" association="Package_yearVersion">
    #       <type href="http://www.omg.org/spec/UML/20131001/UML.xmi#Package"/>
    #     </ownedAttribute>
    #     <ownedAttribute xmi:type="uml:Property" xmi:id="yearVersion-yearVersion" name="yearVersion">
    #       <type href="http://www.omg.org/spec/UML/20131001/UML.xmi#String"/>
    #     </ownedAttribute>
    #   </packagedElement>
    #   <packagedElement xmi:type="uml:Extension" xmi:id="Package_yearVersion" name="A_Package_yearVersion" memberEnd="extension_yearVersion yearVersion-base_Package">
    #     <ownedEnd xmi:type="uml:ExtensionEnd" xmi:id="extension_yearVersion" name="extension_yearVersion" type="yearVersion" isComposite="true" lower="0" upper="1" memberEnd="extension_yearVersion yearVersion-base_Package"/>
    #   </packagedElement>
    #   <packagedElement xmi:type="uml:Stereotype" xmi:id="publicationDate" name="publicationDate">
    #     <ownedAttribute xmi:type="uml:Property" xmi:id="publicationDate-base_Package" name="base_Package" association="Package_publicationDate">
    #       <type href="http://www.omg.org/spec/UML/20131001/UML.xmi#Package"/>
    #     </ownedAttribute>
    #     <ownedAttribute xmi:type="uml:Property" xmi:id="publicationDate-publicationDate" name="publicationDate">
    #       <type href="http://www.omg.org/spec/UML/20131001/UML.xmi#String"/>
    #     </ownedAttribute>
    #   </packagedElement>
    #   <packagedElement xmi:type="uml:Extension" xmi:id="Package_publicationDate" name="A_Package_publicationDate" memberEnd="extension_publicationDate publicationDate-base_Package">
    #     <ownedEnd xmi:type="uml:ExtensionEnd" xmi:id="extension_publicationDate" name="extension_publicationDate" type="publicationDate" isComposite="true" lower="0" upper="1" memberEnd="extension_publicationDate publicationDate-base_Package"/>
    #   </packagedElement>
    # </uml:Profile>

    class Profile < Shale::Mapper
      attribute :owned_comment, OwnedComment, collection: true
      attribute :packaged_element, PackagedElement, collection: true
      attribute :package_import, PackageImport, collection: true
      attribute :id, Shale::Type::String
      attribute :name, Shale::Type::String
      attribute :ns_prefix, Shale::Type::String

      # Is this an EA thing?
      attribute :metamodel_reference, Shale::Type::String

      xml do
        root "Profile"
        # namespace "http://www.omg.org/spec/UML/20131001", "uml"

        map_attribute "id", to: :id, namespace: "http://www.omg.org/spec/XMI/20161101", prefix: "xmi"
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
