# frozen_string_literal: true

module Xmi
  module Sparx
    module Gml
      class CodeList < Lutaml::Model::Serializable
        include HasBaseClass

        attribute :as_dictionary, :string
        attribute :default_code_space, :string

        xml do
          root "CodeList"
          namespace ::Xmi::Namespace::Sparx::Gml

          HasBaseClass.apply_xml_mappings(self)
          map_attribute "asDictionary", to: :as_dictionary
          map_attribute "defaultCodeSpace", to: :default_code_space
        end
      end
    end
  end
end
