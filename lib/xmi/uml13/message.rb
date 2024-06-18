# frozen_string_literal: true

require "shale"

require_relative "messageaction"
require_relative "messageactivator"
require_relative "messageinteraction"
require_relative "messagemessage"
require_relative "messagemessage2"
require_relative "messagepredecessor"
require_relative "messagereceiver"
require_relative "messagesender"
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

class Message < Shale::Mapper
  attribute :name, Shale::Type::Value
  attribute :visibility, Shale::Type::String
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
  attribute :interaction, Shale::Type::Value
  attribute :predecessor, Shale::Type::Value
  attribute :message2, Shale::Type::Value
  attribute :message, Shale::Type::Value
  attribute :activator, Shale::Type::Value
  attribute :action, Shale::Type::Value
  attribute :receiver, Shale::Type::Value
  attribute :sender, Shale::Type::Value
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :model_element_name, ModelElementname, collection: true
  attribute :model_element_visibility, ModelElementvisibility, collection: true
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
  attribute :message_interaction, Messageinteraction, collection: true
  attribute :message_predecessor, Messagepredecessor, collection: true
  attribute :message_message2, Messagemessage2, collection: true
  attribute :message_message, Messagemessage, collection: true
  attribute :message_activator, Messageactivator, collection: true
  attribute :message_action, Messageaction, collection: true
  attribute :message_receiver, Messagereceiver, collection: true
  attribute :message_sender, Messagesender, collection: true
  attribute :model_element_tagged_value, ModelElementtaggedValue, collection: true

  xml do
    root "Message"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "name", to: :name
    map_attribute "visibility", to: :visibility
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
    map_attribute "interaction", to: :interaction
    map_attribute "predecessor", to: :predecessor
    map_attribute "message2", to: :message2
    map_attribute "message", to: :message
    map_attribute "activator", to: :activator
    map_attribute "action", to: :action
    map_attribute "receiver", to: :receiver
    map_attribute "sender", to: :sender
    map_attribute "xmi.id", to: :xmi_id
    map_attribute "xmi.label", to: :xmi_label
    map_attribute "xmi.uuid", to: :xmi_uuid
    map_attribute "href", to: :href
    map_attribute "xmi.idref", to: :xmi_idref
    map_element "ModelElement.name", to: :model_element_name
    map_element "ModelElement.visibility", to: :model_element_visibility
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
    map_element "Message.interaction", to: :message_interaction
    map_element "Message.predecessor", to: :message_predecessor
    map_element "Message.message2", to: :message_message2
    map_element "Message.message", to: :message_message
    map_element "Message.activator", to: :message_activator
    map_element "Message.action", to: :message_action
    map_element "Message.receiver", to: :message_receiver
    map_element "Message.sender", to: :message_sender
    map_element "ModelElement.taggedValue", to: :model_element_tagged_value
  end
end
