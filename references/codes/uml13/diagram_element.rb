# frozen_string_literal: true

require "shale"

require_relative "diagram_element_properties"
require_relative "model_elementtagged_value"
require_relative "xm_iextension"

class DiagramElement < Shale::Mapper
  attribute :geometry, Shale::Type::Value
  attribute :style, Shale::Type::Value
  attribute :subject, Shale::Type::Value
  attribute :seqno, Shale::Type::Value
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :diagram_element_properties, DiagramElementProperties
  attribute :xmi_extension, XMIextension, collection: true
  attribute :model_element_tagged_value, ModelElementtaggedValue

  xml do
    root "DiagramElement"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "geometry", to: :geometry
    map_attribute "style", to: :style
    map_attribute "subject", to: :subject
    map_attribute "seqno", to: :seqno
    map_attribute "xmi.id", to: :xmi_id
    map_attribute "xmi.label", to: :xmi_label
    map_attribute "xmi.uuid", to: :xmi_uuid
    map_attribute "href", to: :href
    map_attribute "xmi.idref", to: :xmi_idref
    map_element "DiagramElementProperties", to: :diagram_element_properties
    map_element "XMI.extension", to: :xmi_extension, prefix: nil, namespace: nil
    map_element "ModelElement.taggedValue", to: :model_element_tagged_value
  end
end
