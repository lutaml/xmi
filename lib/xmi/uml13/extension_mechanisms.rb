require 'shale'

require_relative 'stereotype'
require_relative 'tagged_value'

class ExtensionMechanisms < Shale::Mapper
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :tagged_value, TaggedValue, collection: true
  attribute :stereotype, Stereotype, collection: true

  xml do
    root 'Extension_Mechanisms'
    namespace 'omg.org/UML1.3', 'UML'

    map_attribute 'xmi.id', to: :xmi_id
    map_attribute 'xmi.label', to: :xmi_label
    map_attribute 'xmi.uuid', to: :xmi_uuid
    map_attribute 'href', to: :href
    map_attribute 'xmi.idref', to: :xmi_idref
    map_element 'TaggedValue', to: :tagged_value
    map_element 'Stereotype', to: :stereotype
  end
end
