# frozen_string_literal: true

module Xmi
  module Iso19103
    class AbstractSchema < Shale::Mapper
      attribute :base_package, Shale::Type::String

      xml do
        root "AbstractSchema"

        map_attribute "base_Package",
                      to: :base_package
      end
    end

    class GiInterface < Shale::Mapper
      attribute :base_interface, Shale::Type::String

      xml do
        root "GI_Interface"

        map_attribute "base_Interface",
                      to: :base_interface
      end
    end

    class GiProperty < Shale::Mapper
      attribute :base_property, Shale::Type::String
      attribute :designation, Shale::Type::String
      attribute :iri, Shale::Type::String
      attribute :definition, Shale::Type::String

      xml do
        root "GI_Property"

        map_attribute "base_Property",
                      to: :base_property
        map_attribute "designation",
                      to: :designation
        map_attribute "IRI",
                      to: :iri
        map_attribute "definition",
                      to: :definition
      end
    end

    class GiEnumeration < Shale::Mapper
      attribute :base_enumeration, Shale::Type::String

      xml do
        root "GI_Enumeration"

        map_attribute "base_Enumeration",
                      to: :base_enumeration
      end
    end

    class GiEnumerationLiteral < Shale::Mapper
      attribute :base_enumeration_literal, Shale::Type::String

      xml do
        root "GI_EnumerationLiteral"

        map_attribute "base_EnumerationLiteral",
                      to: :base_enumeration_literal
      end
    end
  end
end
