# frozen_string_literal: true

require_relative "extension"

module Xmi
  class Documentation < Lutaml::Model::Serializable # rubocop:disable Metrics/ClassLength
    attribute :id, :string
    attribute :label, :string
    attribute :uuid, :string
    attribute :href, :string
    attribute :idref, :string
    attribute :type, :string
    attribute :contact, :string, collection: true
    attribute :exporter, :string
    attribute :exporter_version, :string
    attribute :exporter_id, :string
    attribute :long_description, :string, collection: true
    attribute :short_description, :string, collection: true
    attribute :notice, :string, collection: true
    attribute :owner, :string, collection: true
    attribute :timestamp, :time, collection: true
    attribute :extension, Extension, collection: true

    xml do # rubocop:disable Metrics/BlockLength
      root "Documentation"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmi"

      map_attribute "id", to: :id
      map_attribute "label", to: :label
      map_attribute "uuid", to: :uuid
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref
      map_attribute "type", to: :type
      map_attribute "exporter", to: :exporter
      map_attribute "exporterVersion", to: :exporter_version
      map_attribute "exporterID", to: :exporter_id

      map_element "contact", to: :contact, prefix: nil, namespace: nil,
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
      map_element "longDescription", to: :long_description, prefix: nil,
                                     namespace: nil,
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
      map_element "shortDescription", to: :short_description, prefix: nil,
                                      namespace: nil,
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
      map_element "notice", to: :notice, prefix: nil, namespace: nil,
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
      map_element "owner", to: :owner, prefix: nil, namespace: nil,
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
      map_element "timestamp", to: :timestamp, prefix: nil, namespace: nil,
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
