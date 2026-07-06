# frozen_string_literal: true

require "nokogiri"

module Xmi
  class EaRoot
    autoload :XmlParsing, "xmi/ea_root/xml_parsing"
    autoload :CodeGeneration, "xmi/ea_root/code_generation"
    autoload :ExtensionLifecycle, "xmi/ea_root/extension_lifecycle"
    autoload :NamespaceHandling, "xmi/ea_root/namespace_handling"

    extend XmlParsing
    extend CodeGeneration
    extend ExtensionLifecycle
    extend NamespaceHandling

    private_constant :XmlParsing, :CodeGeneration, :ExtensionLifecycle,
                     :NamespaceHandling

    class << self
      def load_extension(xml_path)
        xmi_doc = Nokogiri::XML(File.read(xml_path))
        extension_id = get_module_name(xmi_doc)

        if loaded_extensions.key?(extension_id)
          raise ArgumentError,
                "Extension '#{extension_id}' is already loaded from " \
                "'#{loaded_extensions[extension_id]}'. " \
                "Call unload_extension('#{extension_id}') first if you want to reload it."
        end

        build_extension(xmi_doc)
        update_mappings(extension_id)
        loaded_extensions[extension_id] = xml_path
      end

      def unload_extension(extension_id)
        extension_id = extension_id.to_s.capitalize

        remove_const(extension_id) if const_defined?(extension_id)

        loaded_extensions.delete(extension_id)
      end

      def extension_loaded?(extension_id)
        extension_id = extension_id.to_s.capitalize
        loaded_extensions.key?(extension_id)
      end

      def loaded_extensions
        @loaded_extensions ||= {}
      end
    end
  end
end
