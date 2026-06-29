# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Containment < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :containment, :string
        attribute :position, :integer

        xml do
          root "containment"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute "containment", to: :containment
          map_attribute "position", to: :position
        end
      end
    end
  end
end
