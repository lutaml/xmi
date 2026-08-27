# frozen_string_literal: true

module Xmi
  module Uml
    class OwnedEnd < ValueSpecs
      attribute :association, :string
      attribute :name, :string
      attribute :visibility, :string
      attribute :aggregation, :string
      attribute :member_end, :string
      attribute :is_composite, :boolean

      xml do
        root "ownedEnd"
        map_attribute "association", to: :association
        map_attribute "name", to: :name
        map_attribute "visibility", to: :visibility
        map_attribute "aggregation", to: :aggregation
        map_attribute "memberEnd", to: :member_end
        map_attribute "isComposite", to: :is_composite
      end
    end
  end
end
