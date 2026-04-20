# frozen_string_literal: true

module Xmi
  module Uml
    class UmlModel < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :name, :string
      attribute :profile_application, ProfileApplication, collection: true
      attribute :packaged_element, PackagedElement, collection: true
      attribute :package_import, PackageImport, collection: true
      attribute :diagram, Diagram

      xml do
        root "Model"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "name", to: :name

        map_element "packageImport", to: :package_import, value_map: VALUE_MAP
        map_element "packagedElement", to: :packaged_element,
                                       value_map: VALUE_MAP
        map_element "Diagram", to: :diagram
        map_element "profileApplication", to: :profile_application,
                                          value_map: VALUE_MAP
      end
    end
  end
end
