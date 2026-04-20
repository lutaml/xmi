# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class EndType < Lutaml::Model::Serializable
        attribute :aggregation, :string
        attribute :multiplicity, :string
        attribute :containment, :string

        xml do
          root "type"

          map_attribute :aggregation, to: :aggregation
          map_attribute :multiplicity, to: :multiplicity
          map_attribute :containment, to: :containment
        end
      end
    end
  end
end
