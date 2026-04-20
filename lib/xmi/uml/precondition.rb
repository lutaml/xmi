# frozen_string_literal: true

module Xmi
  module Uml
    class Precondition < Lutaml::Model::Serializable
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :type, ::Xmi::Type::XmiType
      attribute :specification, Specification

      xml do
        root "precondition"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_attribute "type", to: :type
        map_element "specification", to: :specification
      end
    end
  end
end
