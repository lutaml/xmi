# frozen_string_literal: true

module Xmi
  module Uml
    # Shared value-specification surface for typed structural features:
    # the classifier reference (<type> element) plus the multiplicity
    # bounds and default value (<lowerValue>/<upperValue>/<defaultValue>).
    #
    # Element order matches Sparx EA output: type first, then values,
    # lowerValue before upperValue. Inherited element mappings
    # serialize before subclass mappings, so subclasses (OwnedAttribute,
    # OwnedEnd, OwnedParameter) declare only attributes and keep this
    # output order.
    class ValueSpecs < Base
      attribute :uml_type, Uml::Type
      attribute :upper_value, ValueSpecification, polymorphic: true
      attribute :lower_value, ValueSpecification, polymorphic: true
      attribute :default_value, ValueSpecification, polymorphic: true

      xml do
        map_element "type", to: :uml_type
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
