# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedEnd < Base
      attribute :association, :string
      attribute :name, :string
      attribute :visibility, :string
      attribute :aggregation, :string
      attribute :uml_type, Uml::Type
      attribute :member_end, :string
      attribute :upper_value, ValueSpecification, polymorphic: true
      attribute :lower_value, ValueSpecification, polymorphic: true
      attribute :default_value, ValueSpecification, polymorphic: true
      attribute :is_composite, :boolean

      xml do
        root "ownedEnd"
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "visibility", to: :visibility
        map_attribute "aggregation", to: :aggregation
        map_attribute "memberEnd", to: :member_end
        map_attribute "isComposite", to: :is_composite

        map_element "type", to: :uml_type
        # Sparx EA emits lowerValue before upperValue.
        map_element "lowerValue", to: :lower_value,
                                  polymorphic: VALUE_SPECIFICATION_POLYMORPHIC_MAP
        map_element "upperValue", to: :upper_value,
                                  polymorphic: VALUE_SPECIFICATION_POLYMORPHIC_MAP
        map_element "defaultValue", to: :default_value,
                                    polymorphic: VALUE_SPECIFICATION_POLYMORPHIC_MAP
      end
    end
  end
end
