# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Flags < Lutaml::Model::Serializable
        attribute :is_controlled, :integer
        attribute :is_protected, :integer
        attribute :batch_save, :integer
        attribute :batch_load, :integer
        attribute :used_td, :integer
        attribute :log_xml, :integer
        attribute :package_flags, :string

        xml do
          root "flags"

          map_attribute "iscontrolled", to: :is_controlled
          map_attribute "isprotected", to: :is_protected
          map_attribute "batchsave", to: :batch_save
          map_attribute "batchload", to: :batch_load
          map_attribute "usedtd", to: :used_td
          map_attribute "logxml", to: :log_xml
          map_attribute "packageFlags", to: :package_flags
        end
      end
    end
  end
end
