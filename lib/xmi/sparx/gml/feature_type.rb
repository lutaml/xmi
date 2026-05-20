# frozen_string_literal: true

module Xmi
  module Sparx
    module Gml
      class FeatureType < Lutaml::Model::Serializable
        skip_reference_registration
        include HasCollectionProperties

        attribute :by_value_property_type, :string

        xml do
          root "FeatureType"
          namespace ::Xmi::Namespace::Sparx::Gml

          HasCollectionProperties.apply_xml_mappings(self)
          map_attribute "byValuePropertyType", to: :by_value_property_type
        end
      end
    end
  end
end
