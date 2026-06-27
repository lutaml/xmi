# frozen_string_literal: true

module Xmi
  module Uml
    class AssociationGeneralization < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId
      attribute :general, :string

      xml do
        root "generalization"
        namespace :blank

        map_attribute "type", to: :type
        map_attribute "id", to: :id
        map_attribute "general", to: :general
      end
    end
  end
end
