# frozen_string_literal: true

module Xmi
  module Uml
    class UmlModel < Base
      attribute :name, :string
      attribute :profile_application, ProfileApplication, collection: true
      attribute :packaged_element, PackagedElement, collection: true,
                                                    polymorphic: true
      attribute :package_import, PackageImport, collection: true
      attribute :diagram, Diagram

      xml do
        root "Model"
        map_attribute "name", to: :name

        map_element "packageImport", to: :package_import, value_map: VALUE_MAP
        map_element "packagedElement", to: :packaged_element,
                                       polymorphic: PACKAGED_ELEMENT_POLYMORPHIC_MAP
        map_element "Diagram", to: :diagram, form: :qualified
        map_element "profileApplication", to: :profile_application,
                                          value_map: VALUE_MAP
      end
    end
  end
end
