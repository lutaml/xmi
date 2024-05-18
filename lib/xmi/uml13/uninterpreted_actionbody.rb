# frozen_string_literal: true

require "shale"

require_relative "xm_ireference"

module Xmi
  module Uml13
    class UninterpretedActionbody < Shale::Mapper
      attribute :content, Shale::Type::String
      attribute :xmi_reference, XMIreference, collection: true

      xml do
        root "UninterpretedAction.body"
        namespace "omg.org/UML1.3", "UML"

        map_content to: :content
        map_element "XMI.reference", to: :xmi_reference, prefix: nil, namespace: nil
      end
    end
  end
end
