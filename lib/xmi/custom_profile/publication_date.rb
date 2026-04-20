# frozen_string_literal: true

module Xmi
  module CustomProfile
    class PublicationDate < Lutaml::Model::Serializable
      attribute :base_package, :string
      attribute :publication_date, :string

      xml do
        element "publicationDate"
        namespace ::Xmi::Namespace::Sparx::CustomProfile

        map_attribute "base_Package", to: :base_package
        map_attribute "publicationDate", to: :publication_date
      end
    end
  end
end
