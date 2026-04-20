# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedComment < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :name, :string
      attribute :body_element, :string
      attribute :body_attribute, :string
      attribute :annotated_attribute, :string
      attribute :annotated_element, AnnotatedElement

      xml do
        root "ownedComment"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "name", to: :name
        map_attribute "body", to: :body_attribute
        map_attribute "annotatedElement", to: :annotated_attribute

        map_element "annotatedElement", to: :annotated_element
        map_element "body", to: :body_element
      end
    end
  end
end
