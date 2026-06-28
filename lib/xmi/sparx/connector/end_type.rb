# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class EndType < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :aggregation, :string
        attribute :multiplicity, :string
        attribute :containment, :string

        xml do
          root "type"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute :aggregation, to: :aggregation
          map_attribute :multiplicity, to: :multiplicity
          map_attribute :containment, to: :containment
        end
      end
    end
  end
end
