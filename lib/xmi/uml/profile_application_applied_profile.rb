# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<appliedProfile>` element — href reference to a Profile
    # that has been applied to a Package. Child of `<profileApplication>`.
    class ProfileApplicationAppliedProfile < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :type, ::Xmi::Type::XmiType
      attribute :href, :string

      xml do
        root "appliedProfile"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "href", to: :href
      end
    end
  end
end
