# frozen_string_literal: true

module Xmi
  module Uml
    class Waypoint < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :x, :integer
      attribute :y, :integer

      xml do
        root "waypoint"
        namespace ::Xmi::Namespace::Omg::UmlDi

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "x", to: :x
        map_attribute "y", to: :y
      end
    end
  end
end
