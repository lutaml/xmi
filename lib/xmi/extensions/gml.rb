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

      class Property < Shale::Mapper
        attribute :sequence_number, Shale::Type::String
        attribute :base_property, Shale::Type::String

        xml do
          root "property"

          map_attribute "sequenceNumber", to: :sequence_number
          map_attribute "base_Property", to: :base_property
        end
      end
    end
  end
end
