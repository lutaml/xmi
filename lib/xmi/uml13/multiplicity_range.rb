require 'shale'

require_relative 'multiplicity_rangelower'
require_relative 'multiplicity_rangeupper'
require_relative 'xm_iextension'

class MultiplicityRange < Shale::Mapper
  attribute :lower, Shale::Type::Value
  attribute :upper, Shale::Type::Value
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :multiplicity_range_lower, MultiplicityRangelower, collection: true
  attribute :multiplicity_range_upper, MultiplicityRangeupper, collection: true
  attribute :xmi_extension, XMIextension, collection: true

  xml do
    root 'MultiplicityRange'
    namespace 'omg.org/UML1.3', 'UML'

    map_attribute 'lower', to: :lower
    map_attribute 'upper', to: :upper
    map_attribute 'xmi.id', to: :xmi_id
    map_attribute 'xmi.label', to: :xmi_label
    map_attribute 'xmi.uuid', to: :xmi_uuid
    map_attribute 'href', to: :href
    map_attribute 'xmi.idref', to: :xmi_idref
    map_element 'MultiplicityRange.lower', to: :multiplicity_range_lower
    map_element 'MultiplicityRange.upper', to: :multiplicity_range_upper
    map_element 'XMI.extension', to: :xmi_extension, prefix: nil, namespace: nil
  end
end
