# frozen_string_literal: true

require "shale"

require_relative "presentationgeometry"
require_relative "presentationmodel"
require_relative "presentationstyle"
require_relative "presentationview_element"
require_relative "xm_iextension"

class Presentation < Shale::Mapper
  attribute :model, Shale::Type::Value
  attribute :view_element, Shale::Type::Value
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :presentation_geometry, Presentationgeometry, collection: true
  attribute :presentation_style, Presentationstyle, collection: true
  attribute :xmi_extension, XMIextension, collection: true
  attribute :presentation_model, Presentationmodel, collection: true
  attribute :presentation_view_element, PresentationviewElement, collection: true

  xml do
    root "Presentation"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "model", to: :model
    map_attribute "viewElement", to: :view_element
    map_attribute "xmi.id", to: :xmi_id
    map_attribute "xmi.label", to: :xmi_label
    map_attribute "xmi.uuid", to: :xmi_uuid
    map_attribute "href", to: :href
    map_attribute "xmi.idref", to: :xmi_idref
    map_element "Presentation.geometry", to: :presentation_geometry
    map_element "Presentation.style", to: :presentation_style
    map_element "XMI.extension", to: :xmi_extension, prefix: nil, namespace: nil
    map_element "Presentation.model", to: :presentation_model
    map_element "Presentation.viewElement", to: :presentation_view_element
  end
end
