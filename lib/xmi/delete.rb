# frozen_string_literal: true

require_relative "difference"
require_relative "extension"

module Xmi
  class Delete < Lutaml::Model::Serializable
    attribute :id, :string
    attribute :label, :string
    attribute :uuid, :string
    attribute :href, :string
    attribute :idref, :string
    attribute :type, :string
    attribute :target, :string
    attribute :container, :string
    attribute :difference, Difference, collection: true
    attribute :extension, Extension, collection: true

    xml do # rubocop:disable Metrics/BlockLength
      root "Delete"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmlns"

      map_attribute "id", to: :id, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "label", to: :label, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "uuid", to: :uuid, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "type", to: :type, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "target", to: :target
      map_attribute "container", to: :container
      map_element "difference", to: :difference, prefix: nil, namespace: nil,
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
