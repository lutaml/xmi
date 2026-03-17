# frozen_string_literal: true

module Xmi
  class Extension < Lutaml::Model::Serializable
    attribute :id, ::Xmi::Type::XmiId
    attribute :label, ::Xmi::Type::XmiLabel
    attribute :uuid, ::Xmi::Type::XmiUuid
    attribute :href, :string
    attribute :idref, ::Xmi::Type::XmiIdRef
    attribute :type, ::Xmi::Type::XmiType
    attribute :extender, :string
    attribute :extender_id, :string

    xml do
      root "Extension"
      namespace ::Xmi::Namespace::Omg::Xmi

      map_attribute "id", to: :id
      map_attribute "label", to: :label
      map_attribute "uuid", to: :uuid
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref
      map_attribute "type", to: :type
      map_attribute "extender", to: :extender
      map_attribute "extenderID", to: :extender_id
    end
  end
end
