# frozen_string_literal: true

require "shale"

require_relative "enumeration_literalenumeration"
require_relative "enumeration_literalname"
require_relative "xm_iextension"

module Xmi
  module Uml13
    class EnumerationLiteral < Shale::Mapper
      attribute :name, Shale::Type::Value
      attribute :enumeration, Shale::Type::Value
      attribute :xmi_id, Shale::Type::Value
      attribute :xmi_label, Shale::Type::Value
      attribute :xmi_uuid, Shale::Type::Value
      attribute :href, Shale::Type::Value
      attribute :xmi_idref, Shale::Type::Value
      attribute :enumeration_literal_name, EnumerationLiteralname, collection: true
      attribute :xmi_extension, XMIextension, collection: true
      attribute :enumeration_literal_enumeration, EnumerationLiteralenumeration, collection: true

      xml do
        root "EnumerationLiteral"
        namespace "omg.org/UML1.3", "UML"

        map_attribute "name", to: :name
        map_attribute "enumeration", to: :enumeration
        map_attribute "xmi.id", to: :xmi_id
        map_attribute "xmi.label", to: :xmi_label
        map_attribute "xmi.uuid", to: :xmi_uuid
        map_attribute "href", to: :href
        map_attribute "xmi.idref", to: :xmi_idref
        map_element "EnumerationLiteral.name", to: :enumeration_literal_name
        map_element "XMI.extension", to: :xmi_extension, prefix: nil, namespace: nil
        map_element "EnumerationLiteral.enumeration", to: :enumeration_literal_enumeration
      end
    end
  end
end
