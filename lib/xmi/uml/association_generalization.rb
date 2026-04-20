# frozen_string_literal: true

module Xmi
  module Uml
    class AssociationGeneralization < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :general, :string

      xml do
        root "generalization"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "general", to: :general
      end
    end
  end
end
