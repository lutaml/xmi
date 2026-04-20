# frozen_string_literal: true

module Xmi
  module Uml
    class DefaultValue < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :value, :string

      xml do
        root "defaultValue"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "value", to: :value
      end
    end

    class UpperValue < DefaultValue
      xml do
        root "upperValue"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "value", to: :value
      end
    end

    class LowerValue < DefaultValue
      xml do
        root "lowerValue"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "value", to: :value
      end
    end
  end
end
