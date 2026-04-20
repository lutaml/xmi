# frozen_string_literal: true

module Xmi
  module CustomProfile
    class Invariant < Lutaml::Model::Serializable
      attribute :base_constraint, :string

      xml do
        element "invariant"
        namespace ::Xmi::Namespace::Sparx::CustomProfile

        map_attribute "base_Constraint", to: :base_constraint
      end
    end
  end
end
