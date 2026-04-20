# frozen_string_literal: true

module Xmi
  module Sparx
    module Gml
      autoload :HasBaseClass, "xmi/sparx/gml/shared_attributes"
      autoload :HasCollectionProperties, "xmi/sparx/gml/shared_attributes"
      autoload :ApplicationSchema, "xmi/sparx/gml/application_schema"
      autoload :CodeList, "xmi/sparx/gml/code_list"
      autoload :DataType, "xmi/sparx/gml/data_type"
      autoload :Union, "xmi/sparx/gml/union"
      autoload :Enumeration, "xmi/sparx/gml/enumeration"
      autoload :Type, "xmi/sparx/gml/type"
      autoload :FeatureType, "xmi/sparx/gml/feature_type"
      autoload :Property, "xmi/sparx/gml/property"
    end
  end
end
