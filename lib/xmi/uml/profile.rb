# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<Profile>` element (UML 2.5 §22.3). A stereotyped package
    # that extends the UML metamodel. Carries owned comments, package
    # imports, nested packaged elements, and profile-specific metadata
    # (nsPrefix, metamodelReference).
    class Profile < Base
      attribute :name, :string
      attribute :ns_prefix, :string
      attribute :metamodel_reference, :string
      attribute :packaged_element, PackagedElement, collection: true
      attribute :package_import, PackageImport, collection: true
      attribute :owned_comment, OwnedComment, collection: true

      xml do
        root "Profile"
        map_attribute "name", to: :name
        map_attribute "nsPrefix", to: :ns_prefix
        map_attribute "metamodelReference", to: :metamodel_reference

        map_element "ownedComment", to: :owned_comment, value_map: VALUE_MAP
        map_element "packageImport", to: :package_import, value_map: VALUE_MAP
        map_element "packagedElement", to: :packaged_element,
                                       value_map: VALUE_MAP
      end
    end
  end
end
