# frozen_string_literal: true

require_relative "difference"
require_relative "extension"

module Xmi
  class Add < Lutaml::Model::Serializable
    attribute :id, ::Xmi::Type::XmiId
    attribute :label, ::Xmi::Type::XmiLabel
    attribute :uuid, ::Xmi::Type::XmiUuid
    attribute :href, :string
    attribute :idref, ::Xmi::Type::XmiIdRef
    attribute :type, ::Xmi::Type::XmiType
    attribute :target, :string
    attribute :container, :string
    attribute :position, :integer
    attribute :addition, :string
    attribute :difference, Difference, collection: true
    attribute :extension, Extension, collection: true

    xml do
      root "Add"
      namespace ::Xmi::Namespace::Omg::Xmi

      map_attribute "id", to: :id
      map_attribute "label", to: :label
      map_attribute "uuid", to: :uuid
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref
      map_attribute "type", to: :type
      map_attribute "target", to: :target
      map_attribute "container", to: :container
      map_attribute "position", to: :position
      map_attribute "addition", to: :addition
      map_element "difference", to: :difference,
                                value_map: {
                                  from: {
                                    nil: :empty,
                                    empty: :empty,
                                    omitted: :empty
                                  },
                                  to: {
                                    nil: :empty,
                                    empty: :empty,
                                    omitted: :empty
                                  }
                                }
      map_element "Extension", to: :extension,
                               value_map: {
                                 from: {
                                   nil: :empty,
                                   empty: :empty,
                                   omitted: :empty
                                 },
                                 to: {
                                   nil: :empty,
                                   empty: :empty,
                                   omitted: :empty
                                 }
                               }
    end
  end
end
