# frozen_string_literal: true

module Xmi
  module Uml
    class PackagedElement < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :member_end, :string
      attribute :member_ends, MemberEnd, collection: true
      attribute :owned_literal, OwnedLiteral, collection: true
      attribute :owned_operation, OwnedOperation, collection: true

      # EA specific
      attribute :supplier, :string
      attribute :client, :string

      attribute :packaged_element, PackagedElement, collection: true
      attribute :owned_end, OwnedEnd, collection: true
      attribute :owned_attribute, OwnedAttribute, collection: true
      attribute :owned_comment, OwnedComment, collection: true
      attribute :generalization, AssociationGeneralization, collection: true

      xml do
        root "packagedElement"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_attribute "memberEnd", to: :member_end

        # EA specific
        map_attribute "supplier", to: :supplier
        map_attribute "client", to: :client

        map_element "generalization", to: :generalization, value_map: VALUE_MAP
        map_element "ownedComment", to: :owned_comment, value_map: VALUE_MAP
        map_element "ownedEnd", to: :owned_end, value_map: VALUE_MAP
        map_element "ownedLiteral", to: :owned_literal, value_map: VALUE_MAP
        map_element "ownedAttribute", to: :owned_attribute, value_map: VALUE_MAP
        map_element "ownedOperation", to: :owned_operation, value_map: VALUE_MAP
        map_element "packagedElement", to: :packaged_element,
                                       value_map: VALUE_MAP
        map_element "memberEnd", to: :member_ends, value_map: VALUE_MAP
      end
    end
  end
end
