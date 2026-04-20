# frozen_string_literal: true

module Xmi
  module Sparx
    module Gml
      class ApplicationSchema < Lutaml::Model::Serializable
        attribute :version, :string
        attribute :xsd_document, :string
        attribute :altered_xmlns, :string
        attribute :target_namespace, :string
        attribute :base_package, :string

        xml do
          root "ApplicationSchema"
          namespace ::Xmi::Namespace::Sparx::Gml

          map_attribute "version", to: :version
          map_attribute "xsdDocument", to: :xsd_document
          map_attribute "altered_xmlns", to: :altered_xmlns
          map_attribute "targetNamespace", to: :target_namespace
          map_attribute "base_Package", to: :base_package
        end
      end
    end
  end
end
