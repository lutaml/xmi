# frozen_string_literal: true

require_relative "documentation"
require_relative "uml"

module Xmi
  module RootAttributes
    def self.included(klass) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      klass.class_eval do
        attribute :id, :string
        attribute :label, :string
        attribute :uuid, :string
        attribute :href, :string
        attribute :idref, :string
        attribute :type, :string
        attribute :documentation, Documentation
        attribute :bibliography, TheCustomProfile::Bibliography, collection: true
        attribute :basic_doc, TheCustomProfile::BasicDoc, collection: true
        attribute :enumeration, TheCustomProfile::Enumeration, collection: true
        attribute :ocl, TheCustomProfile::Ocl, collection: true
        attribute :invariant, TheCustomProfile::Invariant, collection: true
        attribute :publication_date, TheCustomProfile::PublicationDate, collection: true
        attribute :edition, TheCustomProfile::Edition, collection: true
        attribute :number, TheCustomProfile::Number, collection: true
        attribute :year_version, TheCustomProfile::YearVersion, collection: true
        attribute :informative, TheCustomProfile::Informative, collection: true
        attribute :persistence, TheCustomProfile::Persistence, collection: true
        attribute :abstract, TheCustomProfile::Abstract, collection: true
      end
    end
  end

  class Root < Lutaml::Model::Serializable # rubocop:disable Metrics/ClassLength
    include RootAttributes
    attribute :model, Uml::UmlModel

    xml do # rubocop:disable Metrics/BlockLength
      root "XMI"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmi"

      map_attribute "id", to: :id
      map_attribute "label", to: :label
      map_attribute "uuid", to: :uuid
      map_attribute "href", to: :href, namespace: nil, prefix: nil
      map_attribute "idref", to: :idref
      map_attribute "type", to: :type

      map_element "Documentation", to: :documentation
      map_element "Model", to: :model,
                           namespace: "http://www.omg.org/spec/UML/20131001",
                           prefix: "uml"
      map_element "Bibliography", to: :bibliography,
                                  namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                                  prefix: "thecustomprofile",
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
      map_element "BasicDoc", to: :basic_doc,
                              namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                              prefix: "thecustomprofile",
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
      map_element "enumeration", to: :enumeration,
                                 namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                                 prefix: "thecustomprofile",
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
      map_element "OCL", to: :ocl,
                         namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                         prefix: "thecustomprofile",
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
      map_element "invariant", to: :invariant,
                               namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                               prefix: "thecustomprofile",
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
      map_element "publicationDate", to: :publication_date,
                                     namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                                     prefix: "thecustomprofile",
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
      map_element "edition", to: :edition,
                             namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                             prefix: "thecustomprofile",
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
      map_element "number", to: :number,
                            namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                            prefix: "thecustomprofile",
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
      map_element "yearVersion", to: :year_version,
                                 namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                                 prefix: "thecustomprofile",
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
      map_element "informative", to: :informative,
                                 namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                                 prefix: "thecustomprofile",
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
      map_element "persistence", to: :persistence,
                                 namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                                 prefix: "thecustomprofile",
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
      map_element "Abstract", to: :abstract,
                              namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                              prefix: "thecustomprofile",
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
