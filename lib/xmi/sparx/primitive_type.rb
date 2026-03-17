# frozen_string_literal: true

module Xmi
  module Sparx
    module PrimitiveType
      class PrimitiveTypes < Lutaml::Model::Serializable
        attribute :packaged_element, Uml::PackagedElement, collection: true

        xml do
          root "primitivetypes"

          map_element "packagedElement", to: :packaged_element,
                                         value_map: VALUE_MAP
        end
      end
    end
  end
end
