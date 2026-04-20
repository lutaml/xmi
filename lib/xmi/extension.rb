# frozen_string_literal: true

module Xmi
  class Extension < Lutaml::Model::Serializable
    include XmiIdentity::Attributes

    attribute :extender, :string
    attribute :extender_id, :string

    xml do
      root "Extension"
      namespace ::Xmi::Namespace::Omg::Xmi

      XmiIdentity.apply_xml_mappings(self)

      map_attribute "extender", to: :extender
      map_attribute "extenderID", to: :extender_id
    end
  end
end
