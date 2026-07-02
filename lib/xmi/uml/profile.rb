# frozen_string_literal: true

require_relative "profile_attributes"

module Xmi
  module Uml
    class Profile < Lutaml::Model::Serializable
      skip_reference_registration
      include ProfileAttributes

      attribute :owned_comment, OwnedComment, collection: true

      xml do
        root "Profile"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_attribute "metamodelReference", to: :metamodel_reference
        map_attribute "nsPrefix", to: :ns_prefix

        map_element "ownedComment", to: :owned_comment, value_map: VALUE_MAP
        map_element "packageImport", to: :package_import, value_map: VALUE_MAP
        map_element "packagedElement", to: :packaged_element,
                                       value_map: VALUE_MAP
      end
    end
  end
end
