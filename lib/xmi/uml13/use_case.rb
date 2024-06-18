# frozen_string_literal: true

require "shale"

require_relative "classifierassociation_end"
require_relative "classifierclassifier_in_state"
require_relative "classifierclassifier_role"
require_relative "classifiercreate_action"
require_relative "classifierfeature"
require_relative "classifierinstance"
require_relative "classifierparameter"
require_relative "classifierparticipant"
require_relative "classifierrealization"
require_relative "classifierspecification"
require_relative "classifierstructural_feature"
require_relative "generalizable_elementgeneralization"
require_relative "generalizable_elementis_abstract"
require_relative "generalizable_elementis_leaf"
require_relative "generalizable_elementis_root"
require_relative "generalizable_elementspecialization"
require_relative "model_elementbehavior"
require_relative "model_elementbinding"
require_relative "model_elementconstraint"
require_relative "model_elementelement_reference"
require_relative "model_elementimplementation"
require_relative "model_elementname"
require_relative "model_elementnamespace"
require_relative "model_elementpartition"
require_relative "model_elementpresentation"
require_relative "model_elementprovision"
require_relative "model_elementrequirement"
require_relative "model_elementstereotype"
require_relative "model_elementtagged_value"
require_relative "model_elementtemplate"
require_relative "model_elementtemplate_parameter"
require_relative "model_elementview"
require_relative "model_elementvisibility"
require_relative "namespaceowned_element"
require_relative "use_caseextension_point"
require_relative "xm_iextension"

class UseCase < Shale::Mapper
  attribute :name, Shale::Type::Value
  attribute :visibility, Shale::Type::String
  attribute :is_root, Shale::Type::String
  attribute :is_leaf, Shale::Type::String
  attribute :is_abstract, Shale::Type::String
  attribute :extension_point, Shale::Type::Value
  attribute :binding, Shale::Type::Value
  attribute :template, Shale::Type::Value
  attribute :template_parameter, Shale::Type::Value
  attribute :implementation, Shale::Type::Value
  attribute :view, Shale::Type::Value
  attribute :presentation, Shale::Type::Value
  attribute :namespace, Shale::Type::Value
  attribute :constraint, Shale::Type::Value
  attribute :requirement, Shale::Type::Value
  attribute :provision, Shale::Type::Value
  attribute :stereotype, Shale::Type::Value
  attribute :element_reference, Shale::Type::Value
  attribute :model_element_collaboration, Shale::Type::Value
  attribute :behavior, Shale::Type::Value
  attribute :partition, Shale::Type::Value
  attribute :generalization, Shale::Type::Value
  attribute :specialization, Shale::Type::Value
  attribute :parameter, Shale::Type::Value
  attribute :structural_feature, Shale::Type::Value
  attribute :specification, Shale::Type::Value
  attribute :realization, Shale::Type::Value
  attribute :association_end, Shale::Type::Value
  attribute :participant, Shale::Type::Value
  attribute :create_action, Shale::Type::Value
  attribute :instance, Shale::Type::Value
  attribute :classifier_collaboration, Shale::Type::Value
  attribute :classifier_role, Shale::Type::Value
  attribute :classifier_in_state, Shale::Type::Value
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
  attribute :use_case_extension_point, UseCaseextensionPoint, collection: true
  attribute :xmi_extension, XMIextension, collection: true
  attribute :model_element_binding, ModelElementbinding, collection: true
  attribute :model_element_template, ModelElementtemplate, collection: true
  attribute :model_element_template_parameter, ModelElementtemplateParameter, collection: true
  attribute :model_element_implementation, ModelElementimplementation, collection: true
  attribute :model_element_view, ModelElementview, collection: true
  attribute :model_element_presentation, ModelElementpresentation, collection: true
  attribute :model_element_namespace, ModelElementnamespace, collection: true
  attribute :model_element_constraint, ModelElementconstraint, collection: true
  attribute :model_element_requirement, ModelElementrequirement, collection: true
  attribute :model_element_provision, ModelElementprovision, collection: true
  attribute :model_element_stereotype, ModelElementstereotype, collection: true
  attribute :model_element_element_reference, ModelElementelementReference, collection: true
  attribute :model_element_behavior, ModelElementbehavior, collection: true
  attribute :model_element_partition, ModelElementpartition, collection: true
  attribute :generalizable_element_generalization, GeneralizableElementgeneralization, collection: true
  attribute :generalizable_element_specialization, GeneralizableElementspecialization, collection: true
  attribute :classifier_parameter, Classifierparameter, collection: true
  attribute :classifier_structural_feature, ClassifierstructuralFeature, collection: true
  attribute :classifier_specification, Classifierspecification, collection: true
  attribute :classifier_realization, Classifierrealization, collection: true
  attribute :classifier_association_end, ClassifierassociationEnd, collection: true
  attribute :classifier_participant, Classifierparticipant, collection: true
  attribute :classifier_create_action, ClassifiercreateAction, collection: true
  attribute :classifier_instance, Classifierinstance, collection: true
  attribute :classifier_classifier_role, ClassifierclassifierRole, collection: true
  attribute :classifier_classifier_in_state, ClassifierclassifierInState, collection: true
  attribute :model_element_tagged_value, ModelElementtaggedValue, collection: true
  attribute :namespace_owned_element, NamespaceownedElement, collection: true
  attribute :classifier_feature, Classifierfeature, collection: true

  xml do
    root "UseCase"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "name", to: :name
    map_attribute "visibility", to: :visibility
    map_attribute "isRoot", to: :is_root
    map_attribute "isLeaf", to: :is_leaf
    map_attribute "isAbstract", to: :is_abstract
    map_attribute "extensionPoint", to: :extension_point
    map_attribute "binding", to: :binding
    map_attribute "template", to: :template
    map_attribute "templateParameter", to: :template_parameter
    map_attribute "implementation", to: :implementation
    map_attribute "view", to: :view
    map_attribute "presentation", to: :presentation
    map_attribute "namespace", to: :namespace
    map_attribute "constraint", to: :constraint
    map_attribute "requirement", to: :requirement
    map_attribute "provision", to: :provision
    map_attribute "stereotype", to: :stereotype
    map_attribute "elementReference", to: :element_reference
    map_attribute "ModelElement.collaboration", to: :model_element_collaboration
    map_attribute "behavior", to: :behavior
    map_attribute "partition", to: :partition
    map_attribute "generalization", to: :generalization
    map_attribute "specialization", to: :specialization
    map_attribute "parameter", to: :parameter
    map_attribute "structuralFeature", to: :structural_feature
    map_attribute "specification", to: :specification
    map_attribute "realization", to: :realization
    map_attribute "associationEnd", to: :association_end
    map_attribute "participant", to: :participant
    map_attribute "createAction", to: :create_action
    map_attribute "instance", to: :instance
    map_attribute "Classifier.collaboration", to: :classifier_collaboration
    map_attribute "classifierRole", to: :classifier_role
    map_attribute "classifierInState", to: :classifier_in_state
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
    map_element "UseCase.extensionPoint", to: :use_case_extension_point
    map_element "XMI.extension", to: :xmi_extension, prefix: nil, namespace: nil
    map_element "ModelElement.binding", to: :model_element_binding
    map_element "ModelElement.template", to: :model_element_template
    map_element "ModelElement.templateParameter", to: :model_element_template_parameter
    map_element "ModelElement.implementation", to: :model_element_implementation
    map_element "ModelElement.view", to: :model_element_view
    map_element "ModelElement.presentation", to: :model_element_presentation
    map_element "ModelElement.namespace", to: :model_element_namespace
    map_element "ModelElement.constraint", to: :model_element_constraint
    map_element "ModelElement.requirement", to: :model_element_requirement
    map_element "ModelElement.provision", to: :model_element_provision
    map_element "ModelElement.stereotype", to: :model_element_stereotype
    map_element "ModelElement.elementReference", to: :model_element_element_reference
    map_element "ModelElement.behavior", to: :model_element_behavior
    map_element "ModelElement.partition", to: :model_element_partition
    map_element "GeneralizableElement.generalization", to: :generalizable_element_generalization
    map_element "GeneralizableElement.specialization", to: :generalizable_element_specialization
    map_element "Classifier.parameter", to: :classifier_parameter
    map_element "Classifier.structuralFeature", to: :classifier_structural_feature
    map_element "Classifier.specification", to: :classifier_specification
    map_element "Classifier.realization", to: :classifier_realization
    map_element "Classifier.associationEnd", to: :classifier_association_end
    map_element "Classifier.participant", to: :classifier_participant
    map_element "Classifier.createAction", to: :classifier_create_action
    map_element "Classifier.instance", to: :classifier_instance
    map_element "Classifier.classifierRole", to: :classifier_classifier_role
    map_element "Classifier.classifierInState", to: :classifier_classifier_in_state
    map_element "ModelElement.taggedValue", to: :model_element_tagged_value
    map_element "Namespace.ownedElement", to: :namespace_owned_element
    map_element "Classifier.feature", to: :classifier_feature
  end
end
