# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class Properties < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :ea_type, :string
        attribute :direction, :string

        xml do
          root "properties"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute :ea_type, to: :ea_type
          map_attribute :direction, to: :direction
        end
      end
    end
  end
end
