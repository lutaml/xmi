# frozen_string_literal: true

module Xmi
  module Uml
    # Shared polymorphic dispatch map for any attribute whose value
    # is a PackagedElement dispatched on `xmi:type`. Used by the
    # packaged_element recursion on PackagedElement itself, and by
    # UmlModel.packaged_element.
    #
    # Fallback contract: an unknown `xmi:type` resolves to
    # `Xmi::Uml::PackagedElement` (the union-bag base) via the
    # class_map's Hash default value. This avoids the lutaml-model
    # `Object.const_get(nil)` TypeError when a Sparx XMI emits a
    # type we haven't modelled yet, at the cost of treating the
    # element as generic. polymorphic_map_contract_spec and
    # polymorphic_robustness_spec lock in the graceful-fallback
    # behavior.
    #
    # Two paths land at the base:
    # 1. Missing discriminator — lutaml-model's
    #    `polymorphic_map_defined?` (lib/lutaml/model/attribute.rb)
    #    short-circuits and returns the declared attribute type
    #    (`PackagedElement`). The class_map default is not consulted.
    # 2. Unknown discriminator — `polymorphic_map_defined?` is true,
    #    the class_map lookup hits a missing key, and the Hash default
    #    value supplies the fallback class name.
    PACKAGED_ELEMENT_POLYMORPHIC_MAP = {
      attribute: "xmi:type",
      class_map: Hash.new("Xmi::Uml::PackagedElement").merge!(
        "uml:Class" => "Xmi::Uml::UmlClass",
        "uml:Association" => "Xmi::Uml::Association",
        "uml:AssociationClass" => "Xmi::Uml::AssociationClass",
        "uml:Interface" => "Xmi::Uml::Interface",
        "uml:InstanceSpecification" => "Xmi::Uml::InstanceSpecification",
        "uml:DataType" => "Xmi::Uml::DataType",
        "uml:PrimitiveType" => "Xmi::Uml::PrimitiveType",
        "uml:Enumeration" => "Xmi::Uml::Enumeration",
        "uml:Package" => "Xmi::Uml::Package",
        "uml:Realization" => "Xmi::Uml::Realization",
        "uml:Dependency" => "Xmi::Uml::Dependency",
        "uml:Signal" => "Xmi::Uml::Signal",
        "uml:Extension" => "Xmi::Uml::Extension",
        "uml:Stereotype" => "Xmi::Uml::Stereotype",
        "uml:Usage" => "Xmi::Uml::Usage",
        "uml:Component" => "Xmi::Uml::Component",
      ).freeze,
    }.freeze

    class PackagedElement < Base
      attribute :name, :string
      attribute :visibility, :string
      attribute :is_abstract, :boolean
      attribute :is_leaf, :boolean
      attribute :is_active, :boolean
      attribute :classifier, :string
      attribute :member_end, :string
      attribute :member_ends, MemberEnd, collection: true
      attribute :owned_literal, OwnedLiteral, collection: true
      attribute :owned_operation, OwnedOperation, collection: true

      # EA specific
      attribute :supplier, :string
      attribute :client, :string

      attribute :packaged_element, PackagedElement, collection: true,
                                                    polymorphic: true
      attribute :owned_end, OwnedEnd, collection: true
      attribute :owned_attribute, OwnedAttribute, collection: true
      attribute :owned_comment, OwnedComment, collection: true
      attribute :generalization, AssociationGeneralization, collection: true
      attribute :interface_realization, InterfaceRealization, collection: true
      attribute :slot, Slot, collection: true
      attribute :specification, Specification

      xml do
        root "packagedElement"
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
        map_element "interfaceRealization", to: :interface_realization,
                                            value_map: VALUE_MAP
        map_element "ownedComment", to: :owned_comment, value_map: VALUE_MAP
        map_element "ownedEnd", to: :owned_end, value_map: VALUE_MAP
        map_element "ownedLiteral", to: :owned_literal, value_map: VALUE_MAP
        map_element "ownedAttribute", to: :owned_attribute, value_map: VALUE_MAP
        map_element "ownedOperation", to: :owned_operation, value_map: VALUE_MAP
        map_element "packagedElement", to: :packaged_element,
                                       polymorphic: PACKAGED_ELEMENT_POLYMORPHIC_MAP
        map_element "memberEnd", to: :member_ends, value_map: VALUE_MAP
        map_element "slot", to: :slot, value_map: VALUE_MAP
        map_element "specification", to: :specification
      end
    end
  end
end
