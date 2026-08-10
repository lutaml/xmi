# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedParameter < Base
      attribute :name, :string
      # Sparx emits a PLAIN type attribute on ownedParameter
      # (type="EAID_…" / type="EAnone_void"), not xmi:type.
      #
      # Known limit: lutaml-model matches attributes by local name only,
      # so `type` and `xmi:type` cannot be modelled separately — the
      # inherited xmi:type discriminator is dropped on re-serialization.
      # Needs namespace-aware map_attribute upstream in lutaml-model.
      attribute :type, :string
      attribute :direction, :string
      attribute :visibility, :string
      attribute :is_ordered, :boolean
      attribute :is_unique, :boolean
      attribute :effect, :string
      attribute :upper_value, ValueSpecification, polymorphic: true
      attribute :lower_value, ValueSpecification, polymorphic: true
      attribute :default_value, ValueSpecification, polymorphic: true

      xml do
        root "ownedParameter"
        map_attribute "name", to: :name
        map_attribute "type", to: :type
        map_attribute "direction", to: :direction
        map_attribute "visibility", to: :visibility
        map_attribute "isOrdered", to: :is_ordered
        map_attribute "isUnique", to: :is_unique
        map_attribute "effect", to: :effect

        map_element "upperValue", to: :upper_value,
                                  polymorphic: VALUE_SPECIFICATION_POLYMORPHIC_MAP
        map_element "lowerValue", to: :lower_value,
                                  polymorphic: VALUE_SPECIFICATION_POLYMORPHIC_MAP
        map_element "defaultValue", to: :default_value,
                                    polymorphic: VALUE_SPECIFICATION_POLYMORPHIC_MAP
      end
    end
  end
end
