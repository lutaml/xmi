# frozen_string_literal: true

module Xmi
  module Sparx
    # Common value_map for Sparx elements
    VALUE_MAP = {
      from: { nil: :empty, empty: :empty, omitted: :empty },
      to: { nil: :empty, empty: :empty, omitted: :empty }
    }.freeze

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
  end
end
