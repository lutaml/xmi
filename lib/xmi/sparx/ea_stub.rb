# frozen_string_literal: true

module Xmi
  module Sparx
    class EaStub < Lutaml::Model::Serializable
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :uml_type, :string

      xml do
        root "EAStub"
        namespace ::Xmi::Namespace::Omg::Xmi

        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_attribute "UMLType", to: :uml_type
      end
    end
  end
end
