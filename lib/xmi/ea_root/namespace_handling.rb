# frozen_string_literal: true

module Xmi
  class EaRoot
    module NamespaceHandling
      # Resolve the namespace class for the current extension.
      # Returns the class object (not a name string) for direct use with
      # the xml DSL's +namespace+ directive.
      def resolve_namespace_class
        uri = @def_namespace[:uri]
        prefix = @def_namespace[:name]

        existing = NamespaceRegistry.resolve(uri)
        return existing if existing

        module_name = @module_name
        ns_class_name = "Xmi::Namespace::Dynamic::#{module_name}"
        return Object.const_get(ns_class_name) if Object.const_defined?(ns_class_name)

        Namespace.ensure_dynamic_namespace_module_exists!
        ns_class = Class.new(Lutaml::Xml::Namespace) do
          define_singleton_method(:uri) { uri }
          define_singleton_method(:prefix_default) { prefix }
        end
        Namespace::Dynamic.const_set(module_name, ns_class)

        NamespaceRegistry.register(uri, ns_class)

        ns_class
      end

      # Returns the namespace class _name_ as a string.
      def find_or_create_namespace_class
        klass = resolve_namespace_class
        klass.is_a?(String) ? klass : klass.name
      end
    end
  end
end
