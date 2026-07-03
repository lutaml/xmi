# frozen_string_literal: true

module Xmi
  module UmlDi
    # Common base for concrete UMLDI element classes. Parallel to
    # Xmi::Uml::Base but in the UMLDI namespace (diagram interchange).
    #
    # Subclasses declare only their unique attributes + root element.
    class Base < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId

      xml do
        namespace ::Xmi::Namespace::Omg::UmlDi

        map_attribute "type", to: :type
        map_attribute "id", to: :id
      end
    end
  end
end
