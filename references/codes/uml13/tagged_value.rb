# frozen_string_literal: true

require "shale"

require_relative "tagged_valuemodel_element"
require_relative "tagged_valuestereotype"
require_relative "tagged_valuetag"
require_relative "tagged_valuevalue"
require_relative "xm_iextension"

class TaggedValue < Shale::Mapper
  attribute :content, Shale::Type::String
  attribute :tag, Shale::Type::Value
  attribute :value, Shale::Type::Value
  attribute :model_element, Shale::Type::Value
  attribute :stereotype, Shale::Type::Value
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :tagged_value_tag, TaggedValuetag, collection: true
  attribute :tagged_value_value, TaggedValuevalue, collection: true
  attribute :xmi_extension, XMIextension, collection: true
  attribute :tagged_value_model_element, TaggedValuemodelElement, collection: true
  attribute :tagged_value_stereotype, TaggedValuestereotype, collection: true

  xml do
    root "TaggedValue"
    namespace "omg.org/UML1.3", "UML"

    map_content to: :content
    map_attribute "tag", to: :tag
    map_attribute "value", to: :value
    map_attribute "modelElement", to: :model_element
    map_attribute "stereotype", to: :stereotype
    map_attribute "xmi.id", to: :xmi_id
    map_attribute "xmi.label", to: :xmi_label
    map_attribute "xmi.uuid", to: :xmi_uuid
    map_attribute "href", to: :href
    map_attribute "xmi.idref", to: :xmi_idref
    map_element "TaggedValue.tag", to: :tagged_value_tag
    map_element "TaggedValue.value", to: :tagged_value_value
    map_element "XMI.extension", to: :xmi_extension, prefix: nil, namespace: nil
    map_element "TaggedValue.modelElement", to: :tagged_value_model_element
    map_element "TaggedValue.stereotype", to: :tagged_value_stereotype
  end
end
