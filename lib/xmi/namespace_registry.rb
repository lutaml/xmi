# frozen_string_literal: true

module Xmi
  # Registry for mapping namespace URIs to namespace classes
  #
  # This module provides a central registry for namespace classes,
  # allowing dynamic lookup of namespace classes by URI.
  module NamespaceRegistry
    class << self
      # Get the URI-to-class mapping
      #
      # @return [Hash<String, Class>] The mapping of URIs to namespace classes
      def uri_map
        @uri_map ||= {}
      end

      # Register a URI-to-class mapping
      #
      # @param uri [String] The namespace URI
      # @param namespace_class [Class] The namespace class
      def register(uri, namespace_class)
        uri_map[uri] = namespace_class
      end

      # Resolve a namespace class by URI
      #
      # @param uri [String] The namespace URI to look up
      # @return [Class, nil] The namespace class or nil if not found
      def resolve(uri)
        uri_map[uri]
      end

      # Check if a URI is registered
      #
      # @param uri [String] The namespace URI to check
      # @return [Boolean] True if the URI is registered
      def registered?(uri)
        uri_map.key?(uri)
      end

      # Get all registered URIs
      #
      # @return [Array<String>] List of registered URIs
      def registered_uris
        uri_map.keys
      end

      # Clear the registry (mainly for testing)
      def clear
        @uri_map = {}
      end

      # Bootstrap the registry with all known OMG and Sparx namespaces
      #
      # This method registers all known namespace URIs from the
      # Xmi::Namespace::Omg and Xmi::Namespace::Sparx modules.
      def bootstrap!
        register_omg_namespaces!
        register_sparx_namespaces!
      end

      private

      # Register all OMG namespace URIs
      def register_omg_namespaces!
        return unless defined?(::Xmi::Namespace::Omg)

        # XMI namespaces
        register("http://www.omg.org/spec/XMI/20110701",
                 ::Xmi::Namespace::Omg::Xmi20110701)
        register("http://www.omg.org/spec/XMI/20131001",
                 ::Xmi::Namespace::Omg::Xmi20131001)
        register("http://www.omg.org/spec/XMI/20161101",
                 ::Xmi::Namespace::Omg::Xmi20161101)

        # UML namespaces
        register("http://www.omg.org/spec/UML/20110701",
                 ::Xmi::Namespace::Omg::Uml20110701)
        register("http://www.omg.org/spec/UML/20131001",
                 ::Xmi::Namespace::Omg::Uml20131001)
        register("http://www.omg.org/spec/UML/20161101",
                 ::Xmi::Namespace::Omg::Uml20161101)

        # UMLDI namespaces
        register("http://www.omg.org/spec/UML/20131001/UMLDI",
                 ::Xmi::Namespace::Omg::UmlDi20131001)
        register("http://www.omg.org/spec/UML/20161101/UMLDI",
                 ::Xmi::Namespace::Omg::UmlDi20161101)

        # UMLDC namespaces
        register("http://www.omg.org/spec/UML/20131001/UMLDC",
                 ::Xmi::Namespace::Omg::UmlDc20131001)
        register("http://www.omg.org/spec/UML/20161101/UMLDC",
                 ::Xmi::Namespace::Omg::UmlDc20161101)
      end

      # Register all Sparx namespace URIs
      def register_sparx_namespaces!
        return unless defined?(::Xmi::Namespace::Sparx)

        # Sparx profile namespaces
        register("http://www.sparxsystems.com/profiles/SysPhS/1.0",
                 ::Xmi::Namespace::Sparx::SysPhS)
        register("http://www.sparxsystems.com/profiles/GML/1.0",
                 ::Xmi::Namespace::Sparx::Gml)
        register("http://www.sparxsystems.com/profiles/EAUML/1.0",
                 ::Xmi::Namespace::Sparx::EaUml)
        register("http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                 ::Xmi::Namespace::Sparx::CustomProfile)
        register("http://www.sparxsystems.com/profiles/CityGML/1.0",
                 ::Xmi::Namespace::Sparx::CityGml)

        # Sparx Extension namespace (for EA-specific elements)
        register("http://www.sparxsystems.com/extensions/ea",
                 ::Xmi::Namespace::Sparx::Extension)
      end
    end
  end
end
