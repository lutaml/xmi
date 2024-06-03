# frozen_string_literal: true

require "shale"

require_relative "diagram_compositions"
require_relative "diagram_properties"
require_relative "diagramelement"
require_relative "model_elementtagged_value"
require_relative "xm_iextension"

module Xmi
  module Uml13
    class Diagram < Shale::Mapper
      attribute :name, Shale::Type::Value
      attribute :tool_name, Shale::Type::Value
      attribute :diagram_type, Shale::Type::Value
      attribute :style, Shale::Type::Value
      attribute :owner, Shale::Type::Value
      attribute :xmi_id, Shale::Type::Value
      attribute :xmi_label, Shale::Type::Value
      attribute :xmi_uuid, Shale::Type::Value
      attribute :href, Shale::Type::Value
      attribute :xmi_idref, Shale::Type::Value
      attribute :diagram_properties, DiagramProperties, collection: true
      attribute :xmi_extension, XMIextension, collection: true
      attribute :model_element_tagged_value, ModelElementtaggedValue, collection: true
      attribute :diagram_element, Diagramelement, collection: true
      attribute :diagram_compositions, DiagramCompositions, collection: true

      xml do
        root "Diagram"
        namespace "omg.org/UML1.3", "UML"

        map_attribute "name", to: :name
        map_attribute "toolName", to: :tool_name
        map_attribute "diagramType", to: :diagram_type
        map_attribute "style", to: :style
        map_attribute "owner", to: :owner
        map_attribute "xmi.id", to: :xmi_id
        map_attribute "xmi.label", to: :xmi_label
        map_attribute "xmi.uuid", to: :xmi_uuid
        map_attribute "href", to: :href
        map_attribute "xmi.idref", to: :xmi_idref
        map_element "DiagramProperties", to: :diagram_properties
        map_element "XMI.extension", to: :xmi_extension, prefix: nil, namespace: nil
        map_element "ModelElement.taggedValue", to: :model_element_tagged_value
        map_element "Diagram.element", to: :diagram_element
        map_element "DiagramCompositions", to: :diagram_compositions
      end
    end
  end
end
