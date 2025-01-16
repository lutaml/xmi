# frozen_string_literal: true

Dir[File.join(__dir__, "ea_extensions", "*.rb")].each { |file| require file }

module Xmi
  class EaRoot
    module Gml
      class ApplicationSchema < Lutaml::Model::Serializable
        # prefix altered_ is prepended to xmlns to avoid conflict with
        # reserved keyword
        attribute :version, :string
        attribute :xsd_document, :string
        attribute :altered_xmlns, :string
        attribute :target_namespace, :string
        attribute :base_package, :string

        xml do
          root "ApplicationSchema"

          map_attribute "version", to: :version
          map_attribute "xsdDocument", to: :xsd_document
          map_attribute "altered_xmlns", to: :altered_xmlns
          map_attribute "targetNamespace", to: :target_namespace
          map_attribute "base_Package", to: :base_package
        end
      end

      class CodeList < Lutaml::Model::Serializable
        attribute :as_dictionary, :string
        attribute :default_code_space, :string
        attribute :base_class, :string

        xml do
          root "CodeList"

          map_attribute "asDictionary", to: :as_dictionary
          map_attribute "defaultCodeSpace", to: :default_code_space
          map_attribute "base_Class", to: :base_class
        end
      end

      class DataType < Lutaml::Model::Serializable
        attribute :is_collection, :string
        attribute :no_property_type, :string
        attribute :base_class, :string

        xml do
          root "DataType"

          map_attribute "isCollection", to: :is_collection
          map_attribute "noPropertyType", to: :no_property_type
          map_attribute "base_Class", to: :base_class
        end
      end

      class Union < Lutaml::Model::Serializable
        attribute :is_collection, :string
        attribute :no_property_type, :string
        attribute :base_class, :string

        xml do
          root "Union"

          map_attribute "isCollection", to: :is_collection
          map_attribute "noPropertyType", to: :no_property_type
          map_attribute "base_Class", to: :base_class
        end
      end

      class Enumeration < Lutaml::Model::Serializable
        attribute :base_enumeration, :string

        xml do
          root "Enumeration"

          map_attribute "base_Enumeration", to: :base_enumeration
        end
      end

      class Type < Lutaml::Model::Serializable
        attribute :is_collection, :string
        attribute :no_property_type, :string
        attribute :base_class, :string

        xml do
          root "Type"

          map_attribute "isCollection", to: :is_collection
          map_attribute "noPropertyType", to: :no_property_type
          map_attribute "base_Class", to: :base_class
        end
      end

      class FeatureType < Lutaml::Model::Serializable
        attribute :is_collection, :string
        attribute :no_property_type, :string
        attribute :base_class, :string
        attribute :by_value_property_type, :string

        xml do
          root "FeatureType"

          map_attribute "isCollection", to: :is_collection
          map_attribute "noPropertyType", to: :no_property_type
          map_attribute "base_Class", to: :base_class
          map_attribute "byValuePropertyType", to: :by_value_property_type
        end
      end

      class Property < Lutaml::Model::Serializable
        attribute :sequence_number, :string
        attribute :base_property, :string
        attribute :is_metadata, :string
        attribute :inline_or_by_reference, :string

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
