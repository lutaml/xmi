require 'shale'

require_relative 'model_elementbehavior'
require_relative 'model_elementbinding'
require_relative 'model_elementcollaboration'
require_relative 'model_elementconstraint'
require_relative 'model_elementelement_reference'
require_relative 'model_elementimplementation'
require_relative 'model_elementname'
require_relative 'model_elementnamespace'
require_relative 'model_elementpartition'
require_relative 'model_elementpresentation'
require_relative 'model_elementprovision'
require_relative 'model_elementrequirement'
require_relative 'model_elementstereotype'
require_relative 'model_elementtagged_value'
require_relative 'model_elementtemplate'
require_relative 'model_elementtemplate_parameter'
require_relative 'model_elementview'
require_relative 'model_elementvisibility'
require_relative 'parameterbehavioral_feature'
require_relative 'parameterdefault_value'
require_relative 'parameterkind'
require_relative 'parametersignal'
require_relative 'parametertype'
require_relative 'xm_iextension'

class Parameter < Shale::Mapper
  attribute :name, Shale::Type::Value
  attribute :visibility, Shale::Type::String
  attribute :kind, Shale::Type::String
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
  attribute :behavioral_feature, Shale::Type::Value
  attribute :type, Shale::Type::Value
  attribute :signal, Shale::Type::Value
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :model_element_name, ModelElementname, collection: true
  attribute :model_element_visibility, ModelElementvisibility, collection: true
  attribute :parameter_default_value, ParameterdefaultValue, collection: true
  attribute :parameter_kind, Parameterkind, collection: true
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
  attribute :parameter_behavioral_feature, ParameterbehavioralFeature, collection: true
  attribute :parameter_type, Parametertype, collection: true
  attribute :parameter_signal, Parametersignal, collection: true
  attribute :model_element_tagged_value, ModelElementtaggedValue, collection: true

  xml do
    root 'Parameter'
    namespace 'omg.org/UML1.3', 'UML'

    map_attribute 'name', to: :name
    map_attribute 'visibility', to: :visibility
    map_attribute 'kind', to: :kind
    map_attribute 'binding', to: :binding
    map_attribute 'template', to: :template
    map_attribute 'templateParameter', to: :template_parameter
    map_attribute 'implementation', to: :implementation
    map_attribute 'view', to: :view
    map_attribute 'presentation', to: :presentation
    map_attribute 'namespace', to: :namespace
    map_attribute 'constraint', to: :constraint
    map_attribute 'requirement', to: :requirement
    map_attribute 'provision', to: :provision
    map_attribute 'stereotype', to: :stereotype
    map_attribute 'elementReference', to: :element_reference
    map_attribute 'collaboration', to: :collaboration
    map_attribute 'behavior', to: :behavior
    map_attribute 'partition', to: :partition
    map_attribute 'behavioralFeature', to: :behavioral_feature
    map_attribute 'type', to: :type
    map_attribute 'signal', to: :signal
    map_attribute 'xmi.id', to: :xmi_id
    map_attribute 'xmi.label', to: :xmi_label
    map_attribute 'xmi.uuid', to: :xmi_uuid
    map_attribute 'href', to: :href
    map_attribute 'xmi.idref', to: :xmi_idref
    map_element 'ModelElement.name', to: :model_element_name
    map_element 'ModelElement.visibility', to: :model_element_visibility
    map_element 'Parameter.defaultValue', to: :parameter_default_value
    map_element 'Parameter.kind', to: :parameter_kind
    map_element 'XMI.extension', to: :xmi_extension, prefix: nil, namespace: nil
    map_element 'ModelElement.binding', to: :model_element_binding
    map_element 'ModelElement.template', to: :model_element_template
    map_element 'ModelElement.templateParameter', to: :model_element_template_parameter
    map_element 'ModelElement.implementation', to: :model_element_implementation
    map_element 'ModelElement.view', to: :model_element_view
    map_element 'ModelElement.presentation', to: :model_element_presentation
    map_element 'ModelElement.namespace', to: :model_element_namespace
    map_element 'ModelElement.constraint', to: :model_element_constraint
    map_element 'ModelElement.requirement', to: :model_element_requirement
    map_element 'ModelElement.provision', to: :model_element_provision
    map_element 'ModelElement.stereotype', to: :model_element_stereotype
    map_element 'ModelElement.elementReference', to: :model_element_element_reference
    map_element 'ModelElement.collaboration', to: :model_element_collaboration
    map_element 'ModelElement.behavior', to: :model_element_behavior
    map_element 'ModelElement.partition', to: :model_element_partition
    map_element 'Parameter.behavioralFeature', to: :parameter_behavioral_feature
    map_element 'Parameter.type', to: :parameter_type
    map_element 'Parameter.signal', to: :parameter_signal
    map_element 'ModelElement.taggedValue', to: :model_element_tagged_value
  end
end
