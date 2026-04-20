# frozen_string_literal: true

module Xmi
  module Uml
    class Type < Lutaml::Model::Serializable
      attribute :idref, ::Xmi::Type::XmiIdRef
      attribute :href, :string

      xml do
        root "type"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "idref", to: :idref
        map_attribute "href", to: :href
      end
    end
  end
end
