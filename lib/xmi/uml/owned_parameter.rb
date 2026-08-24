# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedParameter < Base
      attribute :name, :string
      # These are two DIFFERENT attributes that collide here:
      #   xmi:type="uml:Parameter"  — the XMI metaclass discriminator
      #   type="EAnone_void"        — Sparx's classifier reference
      #
      # Known limit: lutaml-model matches attributes by local name only,
      # so both land in this one slot and whichever appears LAST in the
      # input wins. They are not two spellings of one concept, and only
      # one of them can survive a round trip.
      #
      # The slot stays xmi-namespaced, which keeps the discriminator —
      # the general UML XMI shape this gem round-trips. Sparx's
      # classifier reference still parses into it, but re-serializes as
      # `xmi:type`. Restoring the Sparx spelling belongs to the Sparx
      # exporter, not to this shared model: flipping it here would break
      # the general case for every other consumer. Modelling both at
      # once needs namespace-disjoint attribute deserialization
      # upstream (lutaml-model#744).
      attribute :type, ::Xmi::Type::XmiType
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
