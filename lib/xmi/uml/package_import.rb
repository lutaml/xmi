# frozen_string_literal: true

module Xmi
  module Uml
    class ImportedPackage < Lutaml::Model::Serializable
      attribute :href, :string

      xml do
        root "importedPackage"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "href", to: :href
      end
    end

    class PackageImport < Lutaml::Model::Serializable
      attribute :id, ::Xmi::Type::XmiId
      attribute :imported_package, ImportedPackage

      xml do
        root "packageImport"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "id", to: :id

        map_element "importedPackage", to: :imported_package
      end
    end
  end
end
