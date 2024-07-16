# frozen_string_literal: true

Dir[File.join(__dir__, "ea_extensions", "*.rb")].each { |file| require file }

module Xmi
  class EaRoot
    module Gml
      class ApplicationSchema < Shale::Mapper
        attribute :version, Shale::Type::String
        attribute :xsd_document, Shale::Type::String
        attribute :xmlns, Shale::Type::String
        attribute :target_namespace, Shale::Type::String
        attribute :base_package, Shale::Type::String

        xml do
          root "ApplicationSchema"

          map_attribute "version", to: :version
          map_attribute "xsdDocument", to: :xsd_document
          map_attribute "xmlns", to: :xmlns
          map_attribute "targetNamespace", to: :target_namespace
          map_attribute "base_Package", to: :base_package
        end
      end

      class CodeList < Shale::Mapper
        attribute :as_dictionary, Shale::Type::String
        attribute :default_code_space, Shale::Type::String
        attribute :base_class, Shale::Type::String

        xml do
          root "CodeList"

          map_attribute "asDictionary", to: :as_dictionary
          map_attribute "defaultCodeSpace", to: :default_code_space
          map_attribute "base_Class", to: :base_class
        end
      end

      class DataType < Shale::Mapper
        attribute :is_collection, Shale::Type::String
        attribute :no_property_type, Shale::Type::String
        attribute :base_class, Shale::Type::String

        xml do
          root "DataType"

          map_attribute "isCollection", to: :is_collection
          map_attribute "noPropertyType", to: :no_property_type
          map_attribute "base_Class", to: :base_class
        end
      end

      class Union < Shale::Mapper
        attribute :is_collection, Shale::Type::String
        attribute :no_property_type, Shale::Type::String
        attribute :base_class, Shale::Type::String

        xml do
          root "Union"

          map_attribute "isCollection", to: :is_collection
          map_attribute "noPropertyType", to: :no_property_type
          map_attribute "base_Class", to: :base_class
        end
      end

      class Enumeration < Shale::Mapper
        attribute :base_enumeration, Shale::Type::String

        xml do
          root "Enumeration"

          map_attribute "base_Enumeration", to: :base_enumeration
        end
      end

      class Type < Shale::Mapper
        attribute :is_collection, Shale::Type::String
        attribute :no_property_type, Shale::Type::String
        attribute :base_class, Shale::Type::String

        xml do
          root "Type"

          map_attribute "isCollection", to: :is_collection
          map_attribute "noPropertyType", to: :no_property_type
          map_attribute "base_Class", to: :base_class
        end
      end

      class FeatureType < Shale::Mapper
        attribute :is_collection, Shale::Type::String
        attribute :no_property_type, Shale::Type::String
        attribute :base_class, Shale::Type::String
        attribute :by_value_property_type, Shale::Type::String

        xml do
          root "FeatureType"

          map_attribute "isCollection", to: :is_collection
          map_attribute "noPropertyType", to: :no_property_type
          map_attribute "base_Class", to: :base_class
          map_attribute "byValuePropertyType", to: :by_value_property_type
        end
      end

      class Property < Shale::Mapper
        attribute :sequence_number, Shale::Type::String
        attribute :base_property, Shale::Type::String
        attribute :is_metadata, Shale::Type::String
        attribute :inline_or_by_reference, Shale::Type::String

        xml do
          root "property"

          map_attribute "sequenceNumber", to: :sequence_number
          map_attribute "base_Property", to: :base_property
          map_attribute "isMetadata", to: :is_metadata
          map_attribute "inlineOrByReference", to: :inline_or_by_reference
        end
      end
    end
  end
end
