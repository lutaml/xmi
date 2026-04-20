# frozen_string_literal: true

module Xmi
  # Shared XMI identity attributes and their XML mappings.
  #
  # Many XMI elements share the same set of identity attributes:
  # id, label, uuid, href, idref, type. This module centralizes their
  # declarations to prevent divergence bugs (e.g., issue #74 where
  # idref was declared as :string instead of ::Xmi::Type::XmiIdRef).
  #
  # @example
  #   class MyElement < Lutaml::Model::Serializable
  #     include Xmi::XmiIdentity::Attributes
  #
  #     xml do
  #       Xmi::XmiIdentity.apply_xml_mappings(self)
  #     end
  #   end
  module XmiIdentity
    module Attributes
      def self.included(klass)
        klass.class_eval do
          attribute :id, ::Xmi::Type::XmiId
          attribute :label, ::Xmi::Type::XmiLabel
          attribute :uuid, ::Xmi::Type::XmiUuid
          attribute :href, :string
          attribute :idref, ::Xmi::Type::XmiIdRef
          attribute :type, ::Xmi::Type::XmiType
        end
      end
    end

    # Apply XMI identity XML attribute mappings to a mapping builder.
    # Call this inside an `xml do ... end` block.
    #
    # @param mapping [Lutaml::Xml::Mapping] the mapping builder (self in xml block)
    def self.apply_xml_mappings(mapping)
      mapping.map_attribute "id", to: :id
      mapping.map_attribute "label", to: :label
      mapping.map_attribute "uuid", to: :uuid
      mapping.map_attribute "href", to: :href
      mapping.map_attribute "idref", to: :idref
      mapping.map_attribute "type", to: :type
    end
  end
end
