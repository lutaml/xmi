# frozen_string_literal: true

module Xmi
  module Uml
    class Specification < Lutaml::Model::Serializable
      attribute :id, ::Xmi::Type::XmiId
      attribute :type, ::Xmi::Type::XmiType
      attribute :language, :string

      xml do
        root "specification"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "id", to: :id
        map_attribute "type", to: :type
        map_attribute "language", to: :language
      end
    end
  end
end
