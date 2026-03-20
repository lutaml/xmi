# frozen_string_literal: true

module Xmi
  # XMI 2.5.2 (November 2016) version-specific models
  #
  # Falls back to V20131001 and V20110701 for shared models.
  #
  module V20161101
    extend Versioned

    # Register ID
    def self.register_id
      :xmi_20161101
    end

    # Namespace classes this version binds to
    def self.namespace_classes
      [
        Xmi::Namespace::Omg::Xmi20161101,
        Xmi::Namespace::Omg::Uml20161101,
        Xmi::Namespace::Omg::UmlDi20161101,
        Xmi::Namespace::Omg::UmlDc20161101,
      ]
    end

    # Fallback chain: V20131001 → V20110701 → common → default
    def self.fallback_registers
      %i[xmi_20131001 xmi_20110701 xmi_common default]
    end

    # Register all models for this version
    def self.register_models!
      # Extension is different in 2.5.2 - register our version
      register.register_model(Extension, id: :extension)

      # Documentation is same as V20131001 - will be found via fallback
    end

    # XMI 2.5.2 Extension element
    #
    # Different structure from 2.1/2.5.1 - includes additional fields.
    #
    class Extension < Lutaml::Model::Serializable
      attribute :extender, :string
      attribute :extender_id, :string
      attribute :extender_version, :string # NEW in 2.5.2

      xml do
        root "Extension"
        namespace Xmi::Namespace::Omg::Xmi20161101

        map_attribute "extender", to: :extender
        map_attribute "extenderID", to: :extender_id
        map_attribute "extenderVersion", to: :extender_version
      end
    end

    # Auto-register with VersionRegistry
    VersionRegistry.register_version("20161101", self)
  end
end
