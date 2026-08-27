# frozen_string_literal: true

module Xmi
  # XMI 2.1 (July 2011) version-specific models
  #
  # This is the base version that others fall back to for common models.
  #
  module V20110701
    extend Versioned

    define_version(
      register_id: :xmi_20110701,
      namespaces: [
        Xmi::Namespace::Omg::Xmi20110701,
        Xmi::Namespace::Omg::Uml20110701,
      ],
    )

    # Register all models for this version
    def self.register_models!
      register_models extension: Extension, documentation: Documentation
    end

    # XMI 2.1 Extension element
    #
    # Structure is identical in 2.1 and 2.5.1, so V20131001 reuses this.
    #
    class Extension < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :extender, :string
      attribute :extender_id, :string

      xml do
        root "Extension"
        namespace Xmi::Namespace::Omg::Xmi20110701

        map_attribute "extender", to: :extender
        map_attribute "extenderID", to: :extender_id
      end
    end

    # XMI 2.1 Documentation element
    #
    # Structure differs from 2.5.1, so V20131001 defines its own.
    #
    class Documentation < Lutaml::Model::Serializable
      attribute :contact, :string
      attribute :exporter, :string
      attribute :exporter_version, :string
      attribute :exporter_id, :string
      attribute :timestamp, :string
      attribute :remarks, :string

      xml do
        root "Documentation"
        namespace Xmi::Namespace::Omg::Xmi20110701

        map_element "contact", to: :contact
        map_element "exporter", to: :exporter
        map_element "exporterVersion", to: :exporter_version
        map_element "exporterID", to: :exporter_id
        map_element "timestamp", to: :timestamp
        map_element "remarks", to: :remarks
      end
    end

    # Auto-register with VersionRegistry
    VersionRegistry.register_version("20110701", self)
  end
end
