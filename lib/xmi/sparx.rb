# frozen_string_literal: true

module Xmi
  module Sparx
    # Reference to shared VALUE_MAP defined in Xmi module
    # This is used for handling nil, empty, and omitted values consistently
    VALUE_MAP = ::Xmi::VALUE_MAP

    # Autoload declarations - Ruby handles dependency order automatically
    autoload :Element, "xmi/sparx/element"
    autoload :Connector, "xmi/sparx/connector"
    autoload :Diagram, "xmi/sparx/diagram"
    autoload :PrimitiveType, "xmi/sparx/primitive_type"
    autoload :CustomProfile, "xmi/sparx/custom_profile"
    autoload :Gml, "xmi/sparx/gml"
    autoload :EaUml, "xmi/sparx/ea_uml"
    autoload :EaStub, "xmi/sparx/ea_stub"
    autoload :SysPhS, "xmi/sparx/sys_ph_s"
    autoload :Extension, "xmi/sparx/extension"
    autoload :SparxRoot, "xmi/sparx/root"
    autoload :SparxMappings, "xmi/sparx/mappings"
  end
end
