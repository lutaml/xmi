# frozen_string_literal: true

require "shale"

require_relative "view_elementmodel"
require_relative "view_elementpresentation"
require_relative "xm_iextension"

module Xmi
  module Uml13
    class ViewElement < Shale::Mapper
      attribute :model, Shale::Type::Value
      attribute :presentation, Shale::Type::Value
      attribute :xmi_id, Shale::Type::Value
      attribute :xmi_label, Shale::Type::Value
      attribute :xmi_uuid, Shale::Type::Value
      attribute :href, Shale::Type::Value
      attribute :xmi_idref, Shale::Type::Value
      attribute :xmi_extension, XMIextension, collection: true
      attribute :view_element_model, ViewElementmodel, collection: true
      attribute :view_element_presentation, ViewElementpresentation, collection: true

      xml do
        root "ViewElement"
        namespace "omg.org/UML1.3", "UML"

        map_attribute "model", to: :model
        map_attribute "presentation", to: :presentation
        map_attribute "xmi.id", to: :xmi_id
        map_attribute "xmi.label", to: :xmi_label
        map_attribute "xmi.uuid", to: :xmi_uuid
        map_attribute "href", to: :href
        map_attribute "xmi.idref", to: :xmi_idref
        map_element "XMI.extension", to: :xmi_extension, prefix: nil, namespace: nil
        map_element "ViewElement.model", to: :view_element_model
        map_element "ViewElement.presentation", to: :view_element_presentation
      end
    end
  end
end
