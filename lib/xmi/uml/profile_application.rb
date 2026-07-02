# frozen_string_literal: true

require_relative "profile_application_applied_profile"

module Xmi
  module Uml
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
