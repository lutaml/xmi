# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedParameter < ValueSpecs
      attribute :name, :string
      # These are two DIFFERENT attributes on the wire that share the
      # local name "type" and are disjoint by namespace:
      #   xmi:type="uml:Parameter"  — the XMI metaclass discriminator
      #                               (XMI namespace, via XmiType)
      #   type="EAnone_void"        — Sparx's classifier reference
      #                               (no namespace)
      # Unprefixed attributes never take a default namespace, so the
      # pair is (URI, local)-identified and both slots survive a
      # round trip. Requires lutaml-model >= 0.8.53 (namespace-disjoint
      # attribute parsing; earlier versions match by local name only
      # and collapse the two into one slot, last occurrence wins).
      attribute :type, ::Xmi::Type::XmiType
      attribute :classifier_type, :string
      attribute :direction, :string
      attribute :visibility, :string
      attribute :is_ordered, :boolean
      attribute :is_unique, :boolean
      attribute :effect, :string

      xml do
        root "ownedParameter"
        map_attribute "name", to: :name
        map_attribute "type", to: :type
        map_attribute "type", to: :classifier_type
        map_attribute "direction", to: :direction
        map_attribute "visibility", to: :visibility
        map_attribute "isOrdered", to: :is_ordered
        map_attribute "isUnique", to: :is_unique
        map_attribute "effect", to: :effect
      end
    end
  end
end
