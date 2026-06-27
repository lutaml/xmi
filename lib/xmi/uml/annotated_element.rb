# frozen_string_literal: true

module Xmi
  module Uml
    class AnnotatedElement < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :idref, ::Xmi::Type::XmiIdRef

      xml do
        root "annotatedElement"
        namespace :blank

        map_attribute "idref", to: :idref
      end
    end
  end
end
