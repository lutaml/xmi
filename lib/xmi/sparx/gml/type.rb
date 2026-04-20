# frozen_string_literal: true

module Xmi
  module Sparx
    module Gml
      class Type < Lutaml::Model::Serializable
        include HasCollectionProperties

        xml do
          root "Type"
          namespace ::Xmi::Namespace::Sparx::Gml

          HasCollectionProperties.apply_xml_mappings(self)
        end
      end
    end
  end
end
