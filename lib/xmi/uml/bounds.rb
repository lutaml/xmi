# frozen_string_literal: true

module Xmi
  module Uml
    class Bounds < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :x, :integer
      attribute :y, :integer
      attribute :height, :integer
      attribute :width, :integer

      xml do
        root "bounds"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "x", to: :x
        map_attribute "y", to: :y
        map_attribute "height", to: :height
        map_attribute "width", to: :width
      end
    end

    class Waypoint < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :x, :integer
      attribute :y, :integer

      xml do
        root "waypoint"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "x", to: :x
        map_attribute "y", to: :y
      end
    end
  end
end
