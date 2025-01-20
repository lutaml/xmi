# frozen_string_literal: true

module Xmi
  class Extension < Lutaml::Model::Serializable
    attribute :id, :string
    attribute :label, :string
    attribute :uuid, :string
    attribute :href, :string
    attribute :idref, :string
    attribute :type, :string
    attribute :extender, :string
    attribute :extender_id, :string

    xml do
      root "Extension"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmi"

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
