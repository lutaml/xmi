# frozen_string_literal: true

require "shale"

puts "HERE"
require_relative "association_rolebase"
puts "association_role: association_rolebase"
require_relative "association_rolemultiplicity"
puts "association_role: association_rolemultiplicity"
require_relative "associationassociation_end"
puts "association_role: associationassociation_end"
require_relative "associationconnection"
puts "association_role: associationconnection"
require_relative "associationlink"
puts "association_role: associationlink"
require_relative "generalizable_elementgeneralization"
puts "association_role: generalizable_elementgeneralization"
require_relative "generalizable_elementis_abstract"
puts "association_role: generalizable_elementis_abstract"
require_relative "generalizable_elementis_leaf"
puts "association_role: generalizable_elementis_leaf"
require_relative "generalizable_elementis_root"
puts "association_role: generalizable_elementis_root"
require_relative "generalizable_elementspecialization"
puts "association_role: generalizable_elementspecialization"
require_relative "model_elementbehavior"
puts "association_role: model_elementbehavior"
require_relative "model_elementbinding"
puts "association_role: model_elementbinding"
require_relative "model_elementcollaboration"
puts "association_role: model_elementcollaboration"
require_relative "model_elementconstraint"
puts "association_role: model_elementconstraint"
require_relative "model_elementelement_reference"
puts "association_role: model_elementelement_reference"
require_relative "model_elementimplementation"
puts "association_role: model_elementimplementation"
require_relative "model_elementname"
puts "association_role: model_elementname"
require_relative "model_elementpartition"
puts "association_role: model_elementpartition"
require_relative "model_elementpresentation"
puts "association_role: model_elementpresentation"
require_relative "model_elementprovision"
puts "association_role: model_elementprovision"
require_relative "model_elementrequirement"
puts "association_role: model_elementrequirement"
require_relative "model_elementstereotype"
puts "association_role: model_elementstereotype"
require_relative "model_elementtagged_value"
puts "association_role: model_elementtagged_value"
require_relative "model_elementtemplate"
puts "association_role: model_elementtemplate"
require_relative "model_elementtemplate_parameter"
puts "association_role: model_elementtemplate_parameter"
require_relative "model_elementview"
puts "association_role: model_elementview"
require_relative "model_elementvisibility"
puts "association_role: model_elementvisibility"
require_relative "namespaceowned_element"
puts "association_role: namespaceowned_element"
require_relative "xm_iextension"
puts "association_role: xm_iextension"

module Xmi
  module Uml13
    class AssociationRole < Shale::Mapper
      attribute :name, Shale::Type::Value
      attribute :visibility, Shale::Type::String
      attribute :is_root, Shale::Type::String
      attribute :is_leaf, Shale::Type::String
      attribute :is_abstract, Shale::Type::String
      attribute :multiplicity, Shale::Type::Value
      attribute :binding, Shale::Type::Value
      attribute :template, Shale::Type::Value
      attribute :template_parameter, Shale::Type::Value
      attribute :implementation, Shale::Type::Value
      attribute :view, Shale::Type::Value
      attribute :presentation, Shale::Type::Value
      attribute :model_element_namespace, Shale::Type::Value
      attribute :constraint, Shale::Type::Value
      attribute :requirement, Shale::Type::Value
      attribute :provision, Shale::Type::Value
      attribute :stereotype, Shale::Type::Value
      attribute :element_reference, Shale::Type::Value
      attribute :collaboration, Shale::Type::Value
      attribute :behavior, Shale::Type::Value
      attribute :partition, Shale::Type::Value
      attribute :generalization, Shale::Type::Value
      attribute :specialization, Shale::Type::Value
      attribute :link, Shale::Type::Value
      attribute :association_end, Shale::Type::Value
      attribute :base, Shale::Type::Value
      attribute :association_role_namespace, Shale::Type::Value
      attribute :xmi_id, Shale::Type::Value
      attribute :xmi_label, Shale::Type::Value
      attribute :xmi_uuid, Shale::Type::Value
      attribute :href, Shale::Type::Value
      attribute :xmi_idref, Shale::Type::Value
      attribute :model_element_name, ModelElementname, collection: true
      attribute :model_element_visibility, ModelElementvisibility, collection: true
      attribute :generalizable_element_is_root, GeneralizableElementisRoot, collection: true
      attribute :generalizable_element_is_leaf, GeneralizableElementisLeaf, collection: true
      attribute :generalizable_element_is_abstract, GeneralizableElementisAbstract, collection: true
      attribute :association_role_multiplicity, AssociationRolemultiplicity, collection: true
      attribute :xmi_extension, XMIextension, collection: true
      attribute :model_element_binding, ModelElementbinding, collection: true
      attribute :model_element_template, ModelElementtemplate, collection: true
      attribute :model_element_template_parameter, ModelElementtemplateParameter, collection: true
      attribute :model_element_implementation, ModelElementimplementation, collection: true
      attribute :model_element_view, ModelElementview, collection: true
      attribute :model_element_presentation, ModelElementpresentation, collection: true
      attribute :model_element_constraint, ModelElementconstraint, collection: true
      attribute :model_element_requirement, ModelElementrequirement, collection: true
      attribute :model_element_provision, ModelElementprovision, collection: true
      attribute :model_element_stereotype, ModelElementstereotype, collection: true
      attribute :model_element_element_reference, ModelElementelementReference, collection: true
      attribute :model_element_collaboration, ModelElementcollaboration, collection: true
      attribute :model_element_behavior, ModelElementbehavior, collection: true
      attribute :model_element_partition, ModelElementpartition, collection: true
      attribute :generalizable_element_generalization, GeneralizableElementgeneralization, collection: true
      attribute :generalizable_element_specialization, GeneralizableElementspecialization, collection: true
      attribute :association_link, Associationlink, collection: true
      attribute :association_association_end, AssociationassociationEnd, collection: true
      attribute :association_role_base, AssociationRolebase, collection: true
      attribute :model_element_tagged_value, ModelElementtaggedValue, collection: true
      attribute :namespace_owned_element, NamespaceownedElement, collection: true
      attribute :association_connection, Associationconnection, collection: true

      xml do
        root "AssociationRole"
        namespace "omg.org/UML1.3", "UML"

        map_attribute "name", to: :name
        map_attribute "visibility", to: :visibility
        map_attribute "isRoot", to: :is_root
        map_attribute "isLeaf", to: :is_leaf
        map_attribute "isAbstract", to: :is_abstract
        map_attribute "multiplicity", to: :multiplicity
        map_attribute "binding", to: :binding
        map_attribute "template", to: :template
        map_attribute "templateParameter", to: :template_parameter
        map_attribute "implementation", to: :implementation
        map_attribute "view", to: :view
        map_attribute "presentation", to: :presentation
        map_attribute "ModelElement.namespace", to: :model_element_namespace
        map_attribute "constraint", to: :constraint
        map_attribute "requirement", to: :requirement
        map_attribute "provision", to: :provision
        map_attribute "stereotype", to: :stereotype
        map_attribute "elementReference", to: :element_reference
        map_attribute "collaboration", to: :collaboration
        map_attribute "behavior", to: :behavior
        map_attribute "partition", to: :partition
        map_attribute "generalization", to: :generalization
        map_attribute "specialization", to: :specialization
        map_attribute "link", to: :link
        map_attribute "associationEnd", to: :association_end
        map_attribute "base", to: :base
        map_attribute "AssociationRole.namespace", to: :association_role_namespace
        map_attribute "xmi.id", to: :xmi_id
        map_attribute "xmi.label", to: :xmi_label
        map_attribute "xmi.uuid", to: :xmi_uuid
        map_attribute "href", to: :href
        map_attribute "xmi.idref", to: :xmi_idref
        map_element "ModelElement.name", to: :model_element_name
        map_element "ModelElement.visibility", to: :model_element_visibility
        map_element "GeneralizableElement.isRoot", to: :generalizable_element_is_root
        map_element "GeneralizableElement.isLeaf", to: :generalizable_element_is_leaf
        map_element "GeneralizableElement.isAbstract", to: :generalizable_element_is_abstract
        map_element "AssociationRole.multiplicity", to: :association_role_multiplicity
        map_element "XMI.extension", to: :xmi_extension, prefix: nil, namespace: nil
        map_element "ModelElement.binding", to: :model_element_binding
        map_element "ModelElement.template", to: :model_element_template
        map_element "ModelElement.templateParameter", to: :model_element_template_parameter
        map_element "ModelElement.implementation", to: :model_element_implementation
        map_element "ModelElement.view", to: :model_element_view
        map_element "ModelElement.presentation", to: :model_element_presentation
        map_element "ModelElement.constraint", to: :model_element_constraint
        map_element "ModelElement.requirement", to: :model_element_requirement
        map_element "ModelElement.provision", to: :model_element_provision
        map_element "ModelElement.stereotype", to: :model_element_stereotype
        map_element "ModelElement.elementReference", to: :model_element_element_reference
        map_element "ModelElement.collaboration", to: :model_element_collaboration
        map_element "ModelElement.behavior", to: :model_element_behavior
        map_element "ModelElement.partition", to: :model_element_partition
        map_element "GeneralizableElement.generalization", to: :generalizable_element_generalization
        map_element "GeneralizableElement.specialization", to: :generalizable_element_specialization
        map_element "Association.link", to: :association_link
        map_element "Association.associationEnd", to: :association_association_end
        map_element "AssociationRole.base", to: :association_role_base
        map_element "ModelElement.taggedValue", to: :model_element_tagged_value
        map_element "Namespace.ownedElement", to: :namespace_owned_element
        map_element "Association.connection", to: :association_connection
      end
    end
  end
end
