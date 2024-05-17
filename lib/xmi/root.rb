# frozen_string_literal: true

require "shale"
require_relative "documentation"
require_relative "extension"

module Xmi

  class AnnotatedElement < Shale::Mapper
    attribute :idref, Shale::Type::String
    xml do
      root "annotatedElement"
      map_attribute 'idref', to: :idref, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
    end
  end

  class Type < Shale::Mapper
    attribute :idref, Shale::Type::String
    xml do
      root "type"
      map_attribute 'idref', to: :idref, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
    end
  end

  class MemberEnd < Shale::Mapper
    attribute :idref, Shale::Type::String
    xml do
      root "memberEnd"
      map_attribute 'idref', to: :idref, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
    end
  end

  class OwnedEnd < Shale::Mapper
    attribute :type, Shale::Type::String
    attribute :id, Shale::Type::String
    attribute :association, Shale::Type::String
    attribute :type, Type, collection: true
    xml do
      root "ownedEnd"
      map_attribute 'type', to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'id', to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'association', to: :association

      map_element 'type', to: :type
    end
  end

  class UpperValue < Shale::Mapper
    attribute :type, Shale::Type::String
    attribute :id, Shale::Type::String
    attribute :value, Shale::Type::String
    xml do
      root "upperValue"
      map_attribute 'type', to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'id', to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'value', to: :value
    end
  end

  class LowerValue < UpperValue
    xml do
      root "lowerValue"
      map_attribute 'type', to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'id', to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'value', to: :value
    end
  end

  class OwnedLiteral < Shale::Mapper
    attribute :type, Shale::Type::String
    attribute :id, Shale::Type::String
    attribute :name, Shale::Type::String

    xml do
      root "ownedLiteral"
      map_attribute 'type', to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'id', to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'name', to: :value
    end
  end

  class OwnedAttribute < Shale::Mapper
    attribute :type, Shale::Type::String
    attribute :id, Shale::Type::String
    attribute :association, Shale::Type::String
    attribute :type, Type, collection: true
    attribute :upperValue, UpperValue
    attribute :lowerValue, LowerValue

    xml do
      root "ownedAttribute"
      map_attribute 'type', to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'id', to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'association', to: :association

      map_element 'type', to: :type
      map_element 'upperValue', to: :upper_value
      map_element 'lowerValue', to: :lower_value
    end
  end

  class OwnedComment < Shale::Mapper
    attribute :type, Shale::Type::String
    attribute :id, Shale::Type::String
    attribute :body, Shale::Type::String
    attribute :annotated_element, AnnotatedElement, collection: true

    xml do
      root "ownedComment"
      map_attribute 'type', to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'id', to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'name', to: :name

      map_element 'annotatedElement', to: :annotated_element
    end
  end

  class PackagedElement < Shale::Mapper
    attribute :type, Shale::Type::String
    attribute :id, Shale::Type::String
    attribute :name, Shale::Type::String
    attribute :owned_comment, OwnedComment, collection: true
    attribute :member_end, MemberEnd, collection: true
    attribute :owned_literal, OwnedLiteral, collection: true
    attribute :owned_end, OwnedEnd, collection: true
    attribute :packaged_element, PackagedElement, collection: true

    xml do
      root "packagedElement"
      map_attribute 'type', to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'id', to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'name', to: :name
      map_element 'ownedComment', to: :owned_comment
      map_element 'ownedEnd', to: :owned_end
      map_element 'memberEnd', to: :member_end
      map_element 'ownedLiteral', to: :owned_literal
      map_element 'packagedElement', to: :packaged_element
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
      map_attribute 'type', to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'id', to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'x', to: :x
      map_attribute 'y', to: :y
      map_attribute 'height', to: :height
      map_attribute 'width', to: :width
    end
  end

  class Waypoint < Shale::Mapper
    attribute :type, Shale::Type::String
    attribute :id, Shale::Type::String
    attribute :x, Shale::Type::Integer
    attribute :y, Shale::Type::Integer

    xml do
      root "waypoint"
      map_attribute 'type', to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'id', to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'x', to: :x
      map_attribute 'y', to: :y
    end
  end

  class OwnedElement < Shale::Mapper
    attribute :type, Shale::Type::String
    attribute :id, Shale::Type::String
    attribute :text, Shale::Type::String
    attribute :model_element, Shale::Type::String
    attribute :owned_element, OwnedElement, collection: true
    attribute :bounds, Bounds
    attribute :source, Shale::Type::String
    attribute :target, Shale::Type::String
    attribute :waypoint, Waypoint

    xml do
      root "ownedElement"
      map_attribute 'type', to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'id', to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'modelElement', to: :model_element

      map_element 'ownedElement', to: :owned_element
      map_element 'bounds', to: :bounds
      map_element 'source', to: :source
      map_element 'target', to: :target
      map_element 'waypoint', to: :waypoint
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
      map_attribute 'type', to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'id', to: :id, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'isFrame', to: :is_frame
      map_attribute 'modelElement', to: :model_element

      map_element 'ownedElement', to: :owned_element
    end
  end

  class Model < Shale::Mapper
    attribute :type, Shale::Type::String
    attribute :name, Shale::Type::String
    attribute :packaged_element, PackagedElement, collection: true
    attribute :diagram, Diagram

    xml do
      root "Model"
      namespace 'http://www.omg.org/spec/UML/20131001', 'uml'

      map_attribute 'type', to: :type, namespace: "http://www.omg.org/spec/XMI/20131001", prefix: "xmlns"
      map_attribute 'name', to: :name

      map_element 'packagedElement', to: :packaged_element
      map_element 'Diagram', to: :diagram, namespace: "http://www.omg.org/spec/UML/20131001/UMLDI", prefix: "xmlns"
    end
  end

  # <SysPhS:ModelicaParameter base_Package="EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB" name="Standard representation of geographic point location by coordinates"/>
  class SparxSysPhS < Shale::Mapper
    attribute :base_package, Shale::Type::String
    attribute :name, Shale::Type::String

    xml do
      root 'ModelicaParameter'
      namespace "http://www.sparxsystems.com/profiles/SysPhS/1.0", "SysPhS"
      map_attribute 'base_Package', to: :base_package
      map_attribute 'name', to: :name
    end
  end

  # <thecustomprofile:publicationDate base_Package="EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB" publicationDate="2022-09"/>
  class SparxCustomProfilePublicationDate < Shale::Mapper
    attribute :base_package, Shale::Type::String
    attribute :publication_date, Shale::Type::String

    xml do
      root 'publicationDate'
      namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"
      map_attribute 'base_Package', to: :base_package
      map_attribute 'publicationDate', to: :publication_date
    end
  end

  # <thecustomprofile:edition base_Package="EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB" edition="2"/>
  class SparxCustomProfileEdition < Shale::Mapper
    attribute :base_package, Shale::Type::String
    attribute :edition, Shale::Type::String

    xml do
      root 'edition'
      namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"
      map_attribute 'base_Package', to: :base_package
      map_attribute 'edition', to: :edition
    end
  end

  # <thecustomprofile:number base_Package="EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB" number="6709"/>
  class SparxCustomProfileNumber < Shale::Mapper
    attribute :base_package, Shale::Type::String
    attribute :number, Shale::Type::String

    xml do
      root 'number'
      namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"
      map_attribute 'base_Package', to: :base_package
      map_attribute 'number', to: :number
    end
  end

  # <thecustomprofile:yearVersion base_Package="EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB" yearVersion="2022"/>
  class SparxCustomProfileYearVersion < Shale::Mapper
    attribute :base_package, Shale::Type::String
    attribute :year_version, Shale::Type::String

    xml do
      root 'yearVersion'
      namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"
      map_attribute 'base_Package', to: :base_package
      map_attribute 'yearVersion', to: :year_version
    end
  end

  class Root < Shale::Mapper
    attribute :id, Shale::Type::Value
    attribute :label, Shale::Type::String
    attribute :uuid, Shale::Type::String
    attribute :href, Shale::Type::Value
    attribute :idref, Shale::Type::Value
    attribute :type, Shale::Type::Value
    attribute :documentation, Documentation
    attribute :model, Model
    attribute :extension, Extension

    attribute :publication_date, SparxCustomProfilePublicationDate
    attribute :edition, SparxCustomProfileEdition
    attribute :number, SparxCustomProfileNumber
    attribute :year_version, SparxCustomProfileYearVersion
    attribute :modelica_parameter, SparxSysPhS

    # xmlns:UML="omg.org/UML1.3" xmi.version="1.1" timestamp="2022-08-04 16:01:07"

    xml do
      root "XMI"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmi"

      map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "label", to: :label, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "uuid", to: :uuid, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "type", to: :type, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

      map_element 'Documentation', to: :documentation,
        prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_element 'Model', to: :model,
        namespace: 'http://www.omg.org/spec/UML/20131001',
        prefix: 'uml'
      map_element 'Extension', to: :extension

      map_element 'publicationDate', to: :publication_date, namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", prefix: "thecustomprofile"
      map_element 'ModelicaParameter', to: :modelica_parameter, namespace: "http://www.sparxsystems.com/profiles/SysPhS/1.0", prefix: "SysPhS"

      map_element 'edition', to: :edition, namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", prefix: "thecustomprofile"
      map_element 'number', to: :number, namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", prefix: "thecustomprofile"
      map_element 'yearVersion', to: :year_version, namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", prefix: "thecustomprofile"

    end
  end
end
