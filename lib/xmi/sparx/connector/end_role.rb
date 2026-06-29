# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class EndRole < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :name, :string
        attribute :visibility, :string
        attribute :target_scope, :string

        xml do
          root "role"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute :name, to: :name
          map_attribute :visibility, to: :visibility
          map_attribute :targetScope, to: :target_scope
        end
      end
    end
  end
end
