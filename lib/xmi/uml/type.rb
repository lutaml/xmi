# frozen_string_literal: true

module Xmi
  module Uml
    class Type < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :idref, ::Xmi::Type::XmiIdRef
      attribute :href, :string

      xml do
        root "type"
        namespace :blank

        map_attribute "idref", to: :idref
        map_attribute "href", to: :href
      end
    end
  end
end
