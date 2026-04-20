# frozen_string_literal: true

module Xmi
  module Uml
    class ProfileApplicationAppliedProfile < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :href, :string

      xml do
        root "appliedProfile"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "href", to: :href
      end
    end

    class ProfileApplication < Lutaml::Model::Serializable
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :applied_profile, ProfileApplicationAppliedProfile

      xml do
        root "profileApplication"
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id

        map_element "appliedProfile", to: :applied_profile
      end
    end
  end
end
