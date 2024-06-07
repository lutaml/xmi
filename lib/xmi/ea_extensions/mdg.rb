# frozen_string_literal: true

module Xmi
  module Mdg
    class GiElement < Shale::Mapper
      attribute :iri, Shale::Type::String
      attribute :designation, Shale::Type::String
      attribute :definition, Shale::Type::String
      attribute :description, Shale::Type::String
    end

    class AbstractSchema < GiElement
      attribute :base_package, Shale::Type::String

      xml do
        root "AbstractSchema"

        map_attribute "base_Package", to: :base_package
        map_attribute "IRI", to: :iri
        map_attribute "designation", to: :designation
        map_attribute "definition", to: :definition
        map_attribute "description", to: :description
      end
    end

    class GiInterface < GiElement
      attribute :base_interface, Shale::Type::String

      xml do
        root "GI_Interface"

        map_attribute "base_Interface", to: :base_interface
        map_attribute "IRI", to: :iri
        map_attribute "designation", to: :designation
        map_attribute "definition", to: :definition
        map_attribute "description", to: :description
      end
    end

    class GiProperty < GiElement
      attribute :base_property, Shale::Type::String

      xml do
        root "GI_Property"

        map_attribute "base_Property", to: :base_property
        map_attribute "IRI", to: :iri
        map_attribute "designation", to: :designation
        map_attribute "definition", to: :definition
        map_attribute "description", to: :description
      end
    end

    class GiEnumeration < GiElement
      attribute :base_enumeration, Shale::Type::String

      xml do
        root "GI_Enumeration"

        map_attribute "base_Enumeration", to: :base_enumeration
        map_attribute "IRI", to: :iri
        map_attribute "designation", to: :designation
        map_attribute "definition", to: :definition
        map_attribute "description", to: :description
      end
    end

    class GiEnumerationLiteral < GiElement
      attribute :base_enumeration_literal, Shale::Type::String

      xml do
        root "GI_EnumerationLiteral"

        map_attribute "base_EnumerationLiteral", to: :base_enumeration_literal
        map_attribute "IRI", to: :iri
        map_attribute "designation", to: :designation
        map_attribute "definition", to: :definition
        map_attribute "description", to: :description
      end
    end
  end
end
