# frozen_string_literal: true

require "shale"

require_relative "element_reference"
require_relative "model"
require_relative "package"
require_relative "subsystem"

class ModelManagement < Shale::Mapper
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :package, Package, collection: true
  attribute :subsystem, Subsystem, collection: true
  attribute :model, Model, collection: true
  attribute :element_reference, ElementReference, collection: true

  xml do
    root "Model_Management"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "xmi.id", to: :xmi_id
    map_attribute "xmi.label", to: :xmi_label
    map_attribute "xmi.uuid", to: :xmi_uuid
    map_attribute "href", to: :href
    map_attribute "xmi.idref", to: :xmi_idref
    map_element "Package", to: :package
    map_element "Subsystem", to: :subsystem
    map_element "Model", to: :model
    map_element "ElementReference", to: :element_reference
  end
end
