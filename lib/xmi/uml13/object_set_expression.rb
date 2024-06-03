# frozen_string_literal: true

require "shale"

require_relative "expressionbody"
require_relative "expressionlanguage"
require_relative "xm_iextension"

module Xmi
  module Uml13
    class ObjectSetExpression < Shale::Mapper
      attribute :language, Shale::Type::Value
      attribute :body, Shale::Type::Value
      attribute :xmi_id, Shale::Type::Value
      attribute :xmi_label, Shale::Type::Value
      attribute :xmi_uuid, Shale::Type::Value
      attribute :href, Shale::Type::Value
      attribute :xmi_idref, Shale::Type::Value
      attribute :expression_language, Expressionlanguage, collection: true
      attribute :expression_body, Expressionbody, collection: true
      attribute :xmi_extension, XMIextension, collection: true

      xml do
        root "ObjectSetExpression"
        namespace "omg.org/UML1.3", "UML"

        map_attribute "language", to: :language
        map_attribute "body", to: :body
        map_attribute "xmi.id", to: :xmi_id
        map_attribute "xmi.label", to: :xmi_label
        map_attribute "xmi.uuid", to: :xmi_uuid
        map_attribute "href", to: :href
        map_attribute "xmi.idref", to: :xmi_idref
        map_element "Expression.language", to: :expression_language
        map_element "Expression.body", to: :expression_body
        map_element "XMI.extension", to: :xmi_extension, prefix: nil, namespace: nil
      end
    end
  end
end
