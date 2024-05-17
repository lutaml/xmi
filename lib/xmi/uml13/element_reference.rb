require 'shale'

require_relative 'element_referencealias'
require_relative 'element_referencepackage'
require_relative 'element_referencereferenced_element'
require_relative 'element_referencevisibility'
require_relative 'xm_iextension'

class ElementReference < Shale::Mapper
  attribute :visibility, Shale::Type::String
  attribute :alias, Shale::Type::Value
  attribute :referenced_element, Shale::Type::Value
  attribute :package, Shale::Type::Value
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :element_reference_visibility, ElementReferencevisibility, collection: true
  attribute :element_reference_alias, ElementReferencealias, collection: true
  attribute :xmi_extension, XMIextension, collection: true
  attribute :element_reference_referenced_element, ElementReferencereferencedElement, collection: true
  attribute :element_reference_package, ElementReferencepackage, collection: true

  xml do
    root 'ElementReference'
    namespace 'omg.org/UML1.3', 'UML'

    map_attribute 'visibility', to: :visibility
    map_attribute 'alias', to: :alias
    map_attribute 'referencedElement', to: :referenced_element
    map_attribute 'package', to: :package
    map_attribute 'xmi.id', to: :xmi_id
    map_attribute 'xmi.label', to: :xmi_label
    map_attribute 'xmi.uuid', to: :xmi_uuid
    map_attribute 'href', to: :href
    map_attribute 'xmi.idref', to: :xmi_idref
    map_element 'ElementReference.visibility', to: :element_reference_visibility
    map_element 'ElementReference.alias', to: :element_reference_alias
    map_element 'XMI.extension', to: :xmi_extension, prefix: nil, namespace: nil
    map_element 'ElementReference.referencedElement', to: :element_reference_referenced_element
    map_element 'ElementReference.package', to: :element_reference_package
  end
end
