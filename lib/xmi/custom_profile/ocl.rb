# frozen_string_literal: true

module Xmi
  module CustomProfile
    class Ocl < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :base_constraint, :string

      xml do
        element "OCL"
        namespace ::Xmi::Namespace::Sparx::CustomProfile

        map_attribute "base_Constraint", to: :base_constraint
      end
    end
  end
end
