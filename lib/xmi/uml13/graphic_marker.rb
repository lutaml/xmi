# frozen_string_literal: true

require "shale"

require_relative "graphic_markerbody"
require_relative "xm_iextension"

class GraphicMarker < Shale::Mapper
  attribute :body, Shale::Type::Value
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :graphic_marker_body, GraphicMarkerbody, collection: true
  attribute :xmi_extension, XMIextension, collection: true

  xml do
    root "GraphicMarker"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "body", to: :body
    map_attribute "xmi.id", to: :xmi_id
    map_attribute "xmi.label", to: :xmi_label
    map_attribute "xmi.uuid", to: :xmi_uuid
    map_attribute "href", to: :href
    map_attribute "xmi.idref", to: :xmi_idref
    map_element "GraphicMarker.body", to: :graphic_marker_body
    map_element "XMI.extension", to: :xmi_extension, prefix: nil, namespace: nil
  end
end
