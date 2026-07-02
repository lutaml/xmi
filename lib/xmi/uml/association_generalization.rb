# frozen_string_literal: true

module Xmi
  module Uml
    class AssociationGeneralization < Base
      attribute :general, :string

      xml do
        root "generalization"
        map_attribute "general", to: :general
      end
    end
  end
end
