# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedComment < Base
      attribute :name, :string
      attribute :body_element, :string
      attribute :body_attribute, :string
      attribute :annotated_attribute, :string
      attribute :annotated_element, AnnotatedElement, collection: true

      xml do
        root "ownedComment"
        map_attribute "name", to: :name
        map_attribute "body", to: :body_attribute
        map_attribute "annotatedElement", to: :annotated_attribute

        map_element "annotatedElement", to: :annotated_element,
                                        value_map: VALUE_MAP
        map_element "body", to: :body_element
      end
    end
  end
end
