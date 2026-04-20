# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedEnd < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :association, :string
      attribute :name, :string
      attribute :type_attr, :string
      attribute :uml_type, Uml::Type
      attribute :member_end, :string
      attribute :lower, :integer
      attribute :upper, :integer
      attribute :is_composite, :boolean

      xml do
        root "ownedEnd"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "memberEnd", to: :member_end
        map_attribute "type", to: :type_attr
        map_attribute "lower", to: :lower
        map_attribute "upper", to: :upper
        map_attribute "isComposite", to: :is_composite
        map_element "type", to: :uml_type
      end
    end
  end
end
