# frozen_string_literal: true

module Xmi
  # XMI 2.5.1 (October 2013) version-specific models
  #
  # Falls back to V20110701 for shared models (like Extension).
  #
  module V20131001
    extend Versioned

    # Register ID
    def self.register_id
      :xmi_20131001
    end

    # Namespace classes this version binds to
    def self.namespace_classes
      [
        Xmi::Namespace::Omg::Xmi20131001,
        Xmi::Namespace::Omg::Uml20131001,
        Xmi::Namespace::Omg::UmlDi20131001,
        Xmi::Namespace::Omg::UmlDc20131001,
      ]
    end

    # Fallback chain: V20110701 → common → default
    # This allows V20131001 to use V20110701's Extension (same structure)
    def self.fallback_registers
      %i[xmi_20110701 xmi_common default]
    end

    # Register all models for this version
    def self.register_models!
      # Extension is same as V20110701 - will be found via fallback

      # Documentation is different - register our version
      register.register_model(Documentation, id: :documentation)
    end

    # XMI 2.5.1 Documentation element
    #
    # Different structure from 2.1 - includes additional fields.
    #
    class Documentation < Lutaml::Model::Serializable
      attribute :contact, :string
      attribute :exporter, :string
      attribute :exporter_version, :string
      attribute :exporter_id, :string  # NEW in 2.5.1
      attribute :timestamp, :string    # NEW in 2.5.1
      attribute :remarks, :string

      xml do
        root "Documentation"
        namespace Xmi::Namespace::Omg::Xmi20131001

        map_element "contact", to: :contact
        map_element "exporter", to: :exporter
        map_element "exporterVersion", to: :exporter_version
        map_element "exporterID", to: :exporter_id
        map_element "timestamp", to: :timestamp
        map_element "remarks", to: :remarks
      end
    end

    # Auto-register with VersionRegistry
    VersionRegistry.register_version("20131001", self)
  end
end
