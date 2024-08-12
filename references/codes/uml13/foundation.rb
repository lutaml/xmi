# frozen_string_literal: true

require "shale"

require_relative "auxiliary_elements"
require_relative "core"
require_relative "data_types"
require_relative "extension_mechanisms"

class Foundation < Shale::Mapper
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :auxiliary_elements, AuxiliaryElements, collection: true
  attribute :core, Core, collection: true
  attribute :extension_mechanisms, ExtensionMechanisms, collection: true
  attribute :data_types, DataTypes, collection: true

  xml do
    root "Foundation"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "xmi.id", to: :xmi_id
    map_attribute "xmi.label", to: :xmi_label
    map_attribute "xmi.uuid", to: :xmi_uuid
    map_attribute "href", to: :href
    map_attribute "xmi.idref", to: :xmi_idref
    map_element "Auxiliary_Elements", to: :auxiliary_elements
    map_element "Core", to: :core
    map_element "Extension_Mechanisms", to: :extension_mechanisms
    map_element "Data_Types", to: :data_types
  end
end
