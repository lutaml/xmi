# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class Labels < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :rb, :string
        attribute :lb, :string
        attribute :mb, :string
        attribute :rt, :string
        attribute :lt, :string
        attribute :mt, :string

        xml do
          root "labels"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute :rb, to: :rb
          map_attribute :lb, to: :lb
          map_attribute :mb, to: :mb
          map_attribute :rt, to: :rt
          map_attribute :lt, to: :lt
          map_attribute :mt, to: :mt
        end
      end
    end
  end
end
