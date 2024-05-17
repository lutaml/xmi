require 'shale'

class XMIextension < Shale::Mapper
  attribute :content, Shale::Type::String
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :xmi_extender, Shale::Type::Value
  attribute :xmi_extender_id, Shale::Type::Value

  xml do
    root 'XMI.extension'

    map_content to: :content
    map_attribute 'xmi.id', to: :xmi_id
    map_attribute 'xmi.label', to: :xmi_label
    map_attribute 'xmi.uuid', to: :xmi_uuid
    map_attribute 'href', to: :href
    map_attribute 'xmi.idref', to: :xmi_idref
    map_attribute 'xmi.extender', to: :xmi_extender
    map_attribute 'xmi.extenderID', to: :xmi_extender_id
  end
end
