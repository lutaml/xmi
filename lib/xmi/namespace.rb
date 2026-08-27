# frozen_string_literal: true

module Xmi
  module Namespace
    autoload :Omg, "xmi/namespace/omg"
    autoload :Sparx, "xmi/namespace/sparx"
    autoload :Dynamic, "xmi/namespace/dynamic"

    # Canonical namespace scope for XMI document parsing — every
    # namespace a Root-level mapping may resolve against, in
    # resolution order (OMG core first, then Sparx profiles).
    # Declared once; consumed by both Xmi::Root's xml block and
    # Sparx::Mappings::BaseMapping.
    SCOPE = [
      Omg::Xmi,
      Omg::Uml,
      Omg::UmlDi,
      Omg::UmlDc,
      Sparx::Extension,
      Sparx::Gml,
      Sparx::CustomProfile,
      Sparx::SysPhS,
      Sparx::EaUml,
      Sparx::CityGml,
    ].freeze
  end
end
