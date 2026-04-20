# frozen_string_literal: true

module Xmi
  module Uml
    module ProfileAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :packaged_element, PackagedElement, collection: true
          attribute :package_import, PackageImport, collection: true
          attribute :id, ::Xmi::Type::XmiId
          attribute :name, :string
          # attribute :xmi, :string
          # attribute :uml, :string
          attribute :ns_prefix, :string

          # Is this an EA thing?
          attribute :metamodel_reference, :string
        end
      end
    end

    class Profile < Lutaml::Model::Serializable
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
