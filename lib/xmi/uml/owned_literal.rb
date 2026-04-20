# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedLiteral < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :uml_type, Uml::Type

      xml do
        root "ownedLiteral"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "name", to: :name

        map_element "type", to: :uml_type
      end
    end
  end
end
