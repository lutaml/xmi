# frozen_string_literal: true

module Xmi
  module Sparx
    module PrimitiveType
      class PrimitiveTypes < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :packaged_element, Uml::PackagedElement, collection: true

        xml do
          root "primitivetypes"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_element "packagedElement", to: :packaged_element,
                                         value_map: VALUE_MAP
        end
      end
    end
  end
end
