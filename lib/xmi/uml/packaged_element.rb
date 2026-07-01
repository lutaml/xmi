# frozen_string_literal: true

module Xmi
  module Uml
    class PackagedElement < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :visibility, :string
      attribute :is_abstract, :string
      attribute :is_leaf, :string
      attribute :is_active, :string
      attribute :classifier, :string
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
      attribute :interface_realization, InterfaceRealization, collection: true
      attribute :slot, Slot, collection: true
      attribute :specification, Specification

      xml do
        root "packagedElement"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_attribute "visibility", to: :visibility
        map_attribute "isAbstract", to: :is_abstract
        map_attribute "isLeaf", to: :is_leaf
        map_attribute "isActive", to: :is_active
        map_attribute "classifier", to: :classifier
        map_attribute "memberEnd", to: :member_end

        # EA specific
        map_attribute "supplier", to: :supplier
        map_attribute "client", to: :client

        map_element "generalization", to: :generalization, value_map: VALUE_MAP
        map_element "interfaceRealization", to: :interface_realization, value_map: VALUE_MAP
        map_element "ownedComment", to: :owned_comment, value_map: VALUE_MAP
        map_element "ownedEnd", to: :owned_end, value_map: VALUE_MAP
        map_element "ownedLiteral", to: :owned_literal, value_map: VALUE_MAP
        map_element "ownedAttribute", to: :owned_attribute, value_map: VALUE_MAP
        map_element "ownedOperation", to: :owned_operation, value_map: VALUE_MAP
        map_element "packagedElement", to: :packaged_element,
                                       value_map: VALUE_MAP
        map_element "memberEnd", to: :member_ends, value_map: VALUE_MAP
        map_element "slot", to: :slot, value_map: VALUE_MAP
        map_element "specification", to: :specification
      end
    end
  end
end
