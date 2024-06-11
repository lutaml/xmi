# frozen_string_literal: true

module Xmi
  module Mdg
    class GiElement < Shale::Mapper
      attribute :iri, Shale::Type::String
      attribute :designation, Shale::Type::String
      attribute :definition, Shale::Type::String
      attribute :description, Shale::Type::String
    end

    class Abstractschema < GiElement
      attribute :version, Shale::Type::String
      attribute :base_package, Shale::Type::String

      xml do
        root "AbstractSchema"

        map_attribute "IRI", to: :iri
        map_attribute "designation", to: :designation
        map_attribute "definition", to: :definition
        map_attribute "description", to: :description
        map_attribute "version", to: :version
        map_attribute "base_Package", to: :base_package
      end
    end

    class GiClass < GiElement
      attribute :base_class, Shale::Type::String

      xml do
        root "GI_Class"

        map_attribute "IRI", to: :iri
        map_attribute "designation", to: :designation
        map_attribute "definition", to: :definition
        map_attribute "description", to: :description
        map_attribute "base_Class", to: :base_class
      end
    end

    class GiCodeset < GiElement
      attribute :base_datatype, Shale::Type::String

      xml do
        root "GI_CodeSet"

        map_attribute "IRI", to: :iri
        map_attribute "designation", to: :designation
        map_attribute "definition", to: :definition
        map_attribute "description", to: :description
        map_attribute "base_DataType", to: :base_datatype
      end
    end

    class GiDatatype < GiElement
      attribute :base_datatype, Shale::Type::String

      xml do
        root "GI_DataType"

        map_attribute "IRI", to: :iri
        map_attribute "designation", to: :designation
        map_attribute "definition", to: :definition
        map_attribute "description", to: :description
        map_attribute "base_DataType", to: :base_datatype
      end
    end

    class GiEnumeration < GiElement
      attribute :base_enumeration, Shale::Type::String

      xml do
        root "GI_Enumeration"

        map_attribute "IRI", to: :iri
        map_attribute "designation", to: :designation
        map_attribute "definition", to: :definition
        map_attribute "description", to: :description
        map_attribute "base_Enumeration", to: :base_enumeration
      end
    end

    class GiEnumerationliteral < GiElement
      attribute :base_enumerationliteral, Shale::Type::String

      xml do
        root "GI_EnumerationLiteral"

        map_attribute "IRI", to: :iri
        map_attribute "designation", to: :designation
        map_attribute "definition", to: :definition
        map_attribute "description", to: :description
        map_attribute "base_EnumerationLiteral", to: :base_enumerationliteral
      end
    end

    class GiInterface < GiElement
      attribute :base_interface, Shale::Type::String

      xml do
        root "GI_Interface"

        map_attribute "IRI", to: :iri
        map_attribute "designation", to: :designation
        map_attribute "definition", to: :definition
        map_attribute "description", to: :description
        map_attribute "base_Interface", to: :base_interface
      end
    end

    class GiProperty < GiElement
      attribute :base_property, Shale::Type::String

      xml do
        root "GI_Property"

        map_attribute "IRI", to: :iri
        map_attribute "designation", to: :designation
        map_attribute "definition", to: :definition
        map_attribute "description", to: :description
        map_attribute "base_Property", to: :base_property
      end
    end
  end
end
