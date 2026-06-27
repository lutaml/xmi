# frozen_string_literal: true

module Xmi
  module Uml
    class MemberEnd < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :idref, ::Xmi::Type::XmiIdRef

      xml do
        root "memberEnd"
        namespace :blank

        map_attribute "idref", to: :idref
      end
    end
  end
end
