# frozen_string_literal: true

module Xmi
  module Uml
    class AnnotatedElement < Lutaml::Model::Serializable
      attribute :idref, ::Xmi::Type::XmiIdRef

      xml do
        root "annotatedElement"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "idref", to: :idref
      end
    end
  end
end
