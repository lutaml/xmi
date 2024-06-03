# frozen_string_literal: true

require "shale"

module Xmi
  module Uml13
    class XMIreference < Shale::Mapper
      attribute :content, Shale::Type::String
      attribute :href, Shale::Type::Value
      attribute :xmi_idref, Shale::Type::Value

      xml do
        root "XMI.reference"

        map_content to: :content
        map_attribute "href", to: :href
        map_attribute "xmi.idref", to: :xmi_idref
      end
    end
  end
end
