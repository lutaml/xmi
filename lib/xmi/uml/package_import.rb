# frozen_string_literal: true

module Xmi
  module Uml
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
