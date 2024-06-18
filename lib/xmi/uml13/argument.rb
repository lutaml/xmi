# frozen_string_literal: true

require "shale"

require_relative "argumentaction"
require_relative "argumentvalue"
require_relative "xm_iextension"

class Argument < Shale::Mapper
  attribute :action, Shale::Type::Value
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :argument_value, Argumentvalue, collection: true
  attribute :xmi_extension, XMIextension, collection: true
  attribute :argument_action, Argumentaction, collection: true

  xml do
    root "Argument"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "action", to: :action
    map_attribute "xmi.id", to: :xmi_id
    map_attribute "xmi.label", to: :xmi_label
    map_attribute "xmi.uuid", to: :xmi_uuid
    map_attribute "href", to: :href
    map_attribute "xmi.idref", to: :xmi_idref
    map_element "Argument.value", to: :argument_value
    map_element "XMI.extension", to: :xmi_extension, prefix: nil, namespace: nil
    map_element "Argument.action", to: :argument_action
  end
end
