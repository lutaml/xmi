# frozen_string_literal: true

module Xmi
  module Uml
    # Abstract UML ValueSpecification. UML 2.5 §9.8 — the abstract
    # parent of OpaqueExpression, LiteralString, LiteralInteger,
    # LiteralBoolean, LiteralUnlimitedNatural, LiteralNull, etc.
    #
    # Used as the type of `Slot#value` and other polymorphic value
    # attributes so the parser can dispatch on `xmi:type` to the
    # right concrete subclass.
    #
    # Concrete subclasses live in their own files (literal_string.rb,
    # opaque_expression.rb, etc.). Add new literals as a new file plus
    # an entry in POLYMORPHIC_MAP below — OCP-friendly, no edits to
    # callers.
    class ValueSpecification < Base
      attribute :type, ::Xmi::Type::XmiType, polymorphic_class: true

      xml do
        root "valueSpecification"
        map_attribute "type", to: :type
      end
    end

    # Shared polymorphic dispatch map for any attribute whose value
    # is a ValueSpecification dispatched on `xmi:type`. Consumers:
    # Slot#value, OwnedAttribute#upper_value/#lower_value/#default_value,
    # OwnedEnd#upper_value/#lower_value/#default_value,
    # OwnedParameter#upper_value/#lower_value/#default_value.
    #
    # The literal class names are string form because lutaml-model's
    # resolve_polymorphic_class calls Object.const_get on the value.
    #
    # Fallback contract: an unknown `xmi:type` resolves to
    # `Xmi::Uml::ValueSpecification` (the abstract base) via the
    # class_map's Hash default value. polymorphic_map_contract_spec
    # and polymorphic_robustness_spec lock in the graceful-fallback
    # behavior.
    #
    # Two paths land at the base (see PACKAGED_ELEMENT_POLYMORPHIC_MAP
    # for the full rationale): missing discriminator short-circuits via
    # lutaml-model's `polymorphic_map_defined?`; unknown discriminator
    # hits the Hash default value.
    VALUE_SPECIFICATION_POLYMORPHIC_MAP = {
      attribute: "xmi:type",
      class_map: Hash.new("Xmi::Uml::ValueSpecification").merge!(
        "uml:OpaqueExpression" => "Xmi::Uml::OpaqueExpression",
        "uml:LiteralString" => "Xmi::Uml::LiteralString",
        "uml:LiteralInteger" => "Xmi::Uml::LiteralInteger",
        "uml:LiteralBoolean" => "Xmi::Uml::LiteralBoolean",
        "uml:LiteralUnlimitedNatural" => "Xmi::Uml::LiteralUnlimitedNatural",
        "uml:LiteralNull" => "Xmi::Uml::LiteralNull",
      ).freeze,
    }.freeze
  end
end
