# frozen_string_literal: true

module Xmi
  module Uml
    class ImportedPackage < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :href, :string

      xml do
        root "importedPackage"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "href", to: :href
      end
    end
  end
end
