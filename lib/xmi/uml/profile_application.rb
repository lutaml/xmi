# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<profileApplication>` element — records that a Profile has
    # been applied to the containing Package. Carries a single
    # `<appliedProfile>` child holding the href reference.
    class ProfileApplication < Base
      attribute :applied_profile, ProfileApplicationAppliedProfile

      xml do
        root "profileApplication"
        map_element "appliedProfile", to: :applied_profile
      end
    end
  end
end
