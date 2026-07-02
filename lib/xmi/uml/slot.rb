# frozen_string_literal: true

module Xmi
  module Uml
    class Slot < Base
      attribute :defining_feature, :string
      attribute :value, ValueSpecification, collection: true, polymorphic: true

      xml do
        root "slot"
        map_attribute "definingFeature", to: :defining_feature

        map_element "value", to: :value,
                             polymorphic: VALUE_SPECIFICATION_POLYMORPHIC_MAP
      end
    end
  end
end
