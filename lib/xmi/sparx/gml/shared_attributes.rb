# frozen_string_literal: true

module Xmi
  module Sparx
    module Gml
      # Shared attribute modules for GML stereotype classes.
      # Reduces duplication across DataType, Type, FeatureType, etc.

      module HasBaseClass
        def self.included(klass)
          klass.class_eval do
            attribute :base_class, :string
          end
        end

        def self.apply_xml_mappings(mapping)
          mapping.map_attribute "base_Class", to: :base_class
        end
      end

      module HasCollectionProperties
        def self.included(klass)
          klass.class_eval do
            include HasBaseClass
            attribute :is_collection, :string
            attribute :no_property_type, :string
          end
        end

        def self.apply_xml_mappings(mapping)
          HasBaseClass.apply_xml_mappings(mapping)
          mapping.map_attribute "isCollection", to: :is_collection
          mapping.map_attribute "noPropertyType", to: :no_property_type
        end
      end
    end
  end
end
