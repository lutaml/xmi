# frozen_string_literal: true

module Xmi
  # Base module for version-specific XMI model trees.
  #
  # Each version module (V20110701, V20131001, V20161101) extends this
  # and provides its own register and namespace bindings.
  #
  # @example
  #   module Xmi::V20131001
  #     extend Xmi::Versioned
  #
  #     def self.register_id
  #       :xmi_20131001
  #     end
  #
  #     def self.namespace_classes
  #       [Xmi::Namespace::Omg::Xmi20131001, Xmi::Namespace::Omg::Uml20131001]
  #     end
  #
  #     def self.register_models!
  #       # Register version-specific models
  #     end
  #   end
  #
  module Versioned
    # @api public
    # Called when a module extends Versioned
    def self.extended(base)
      base.class_eval do
        @version_register = nil
        @initialized = false
      end
    end

    # @api public
    # Get the register for this version
    #
    # @return [Lutaml::Model::Register] The version-specific register
    def register
      @register ||= create_register
    end

    # @api public
    # Create and configure the register
    #
    # @return [Lutaml::Model::Register]
    def create_register
      reg = Lutaml::Model::Register.new(register_id, fallback: fallback_registers)

      # Register in GlobalRegister first
      Lutaml::Model::GlobalRegister.register(reg)

      # Bind to all namespaces this version handles
      namespace_classes.each do |ns_class|
        reg.bind_namespace(ns_class)
      end

      @version_register = reg
    end

    # @api public
    # Initialize this version's model tree
    #
    # This should be called after all version-specific models are defined.
    # It registers all models in this version's register.
    #
    # @return [void]
    def init_models!
      return if @initialized

      register
      register_models!

      @initialized = true
    end

    # @api public
    # Register all models for this version
    #
    # Override in each version module to register specific models.
    #
    # @return [void]
    def register_models!
      raise NotImplementedError,
            "Each version must implement #register_models!"
    end

    # @api public
    # Get the register ID for this version
    #
    # @return [Symbol]
    def register_id
      raise NotImplementedError,
            "Each version must implement #register_id"
    end

    # @api public
    # Get namespace classes this version binds to
    #
    # @return [Array<Class>] Array of Lutaml::Xml::Namespace subclasses
    def namespace_classes
      raise NotImplementedError,
            "Each version must implement #namespace_classes"
    end

    # @api public
    # Get fallback register IDs for this version
    #
    # Default: fall back to common, then default.
    # Override for version chains (e.g., V20161101 falls back to V20131001).
    #
    # @return [Array<Symbol>]
    def fallback_registers
      %i[xmi_common default]
    end

    # @api public
    # Get the XMI namespace class for this version
    #
    # @return [Class, nil]
    def xmi_namespace
      namespace_classes.find { |ns| ns.uri.include?("/XMI/") }
    end

    # @api public
    # Get the UML namespace class for this version
    #
    # @return [Class, nil]
    def uml_namespace
      namespace_classes.find { |ns| ns.uri.include?("/UML/") && !ns.uri.include?("UMLD") }
    end

    # @api public
    # Check if this version has been initialized
    #
    # @return [Boolean]
    def initialized?
      @initialized
    end
  end
end
