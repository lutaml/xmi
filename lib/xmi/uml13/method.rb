# frozen_string_literal: true

require "shale"

require_relative "behavioral_featureis_query"
require_relative "behavioral_featureparameter"
require_relative "behavioral_featureraised_exception"
require_relative "featureclassifier_role"
require_relative "featureowner"
require_relative "featureowner_scope"
require_relative "methodbody"
require_relative "methodspecification"
require_relative "model_elementbehavior"
require_relative "model_elementbinding"
require_relative "model_elementcollaboration"
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
require_relative "xm_iextension"

module Xmi
  module Uml13
    class Method < Shale::Mapper
      attribute :name, Shale::Type::Value
      attribute :visibility, Shale::Type::String
      attribute :owner_scope, Shale::Type::String
      attribute :is_query, Shale::Type::String
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
      attribute :collaboration, Shale::Type::Value
      attribute :behavior, Shale::Type::Value
      attribute :partition, Shale::Type::Value
      attribute :owner, Shale::Type::Value
      attribute :classifier_role, Shale::Type::Value
      attribute :raised_exception, Shale::Type::Value
      attribute :specification, Shale::Type::Value
      attribute :xmi_id, Shale::Type::Value
      attribute :xmi_label, Shale::Type::Value
      attribute :xmi_uuid, Shale::Type::Value
      attribute :href, Shale::Type::Value
      attribute :xmi_idref, Shale::Type::Value
      attribute :model_element_name, ModelElementname, collection: true
      attribute :model_element_visibility, ModelElementvisibility, collection: true
      attribute :feature_owner_scope, FeatureownerScope, collection: true
      attribute :behavioral_feature_is_query, BehavioralFeatureisQuery, collection: true
      attribute :method_body, Methodbody, collection: true
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
      attribute :model_element_collaboration, ModelElementcollaboration, collection: true
      attribute :model_element_behavior, ModelElementbehavior, collection: true
      attribute :model_element_partition, ModelElementpartition, collection: true
      attribute :feature_owner, Featureowner, collection: true
      attribute :feature_classifier_role, FeatureclassifierRole, collection: true
      attribute :behavioral_feature_raised_exception, BehavioralFeatureraisedException, collection: true
      attribute :method_specification, Methodspecification, collection: true
      attribute :model_element_tagged_value, ModelElementtaggedValue, collection: true
      attribute :behavioral_feature_parameter, BehavioralFeatureparameter, collection: true

      xml do
        root "Method"
        namespace "omg.org/UML1.3", "UML"

        map_attribute "name", to: :name
        map_attribute "visibility", to: :visibility
        map_attribute "ownerScope", to: :owner_scope
        map_attribute "isQuery", to: :is_query
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
        map_attribute "collaboration", to: :collaboration
        map_attribute "behavior", to: :behavior
        map_attribute "partition", to: :partition
        map_attribute "owner", to: :owner
        map_attribute "classifierRole", to: :classifier_role
        map_attribute "raisedException", to: :raised_exception
        map_attribute "specification", to: :specification
        map_attribute "xmi.id", to: :xmi_id
        map_attribute "xmi.label", to: :xmi_label
        map_attribute "xmi.uuid", to: :xmi_uuid
        map_attribute "href", to: :href
        map_attribute "xmi.idref", to: :xmi_idref
        map_element "ModelElement.name", to: :model_element_name
        map_element "ModelElement.visibility", to: :model_element_visibility
        map_element "Feature.ownerScope", to: :feature_owner_scope
        map_element "BehavioralFeature.isQuery", to: :behavioral_feature_is_query
        map_element "Method.body", to: :method_body
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
        map_element "ModelElement.collaboration", to: :model_element_collaboration
        map_element "ModelElement.behavior", to: :model_element_behavior
        map_element "ModelElement.partition", to: :model_element_partition
        map_element "Feature.owner", to: :feature_owner
        map_element "Feature.classifierRole", to: :feature_classifier_role
        map_element "BehavioralFeature.raisedException", to: :behavioral_feature_raised_exception
        map_element "Method.specification", to: :method_specification
        map_element "ModelElement.taggedValue", to: :model_element_tagged_value
        map_element "BehavioralFeature.parameter", to: :behavioral_feature_parameter
      end
    end
  end
end
