# frozen_string_literal: true

module Xmi
  module Uml
    class MemberEnd < Lutaml::Model::Serializable
      attribute :idref, ::Xmi::Type::XmiIdRef

      xml do
        root "memberEnd"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "idref", to: :idref
      end
    end
  end
end
