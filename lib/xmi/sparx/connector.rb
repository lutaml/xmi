# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      autoload :Model, "xmi/sparx/connector/model"
      autoload :EndRole, "xmi/sparx/connector/end_role"
      autoload :EndType, "xmi/sparx/connector/end_type"
      autoload :EndModifiers, "xmi/sparx/connector/end_modifiers"
      autoload :EndConstraint, "xmi/sparx/connector/end_constraint"
      autoload :EndConstraints, "xmi/sparx/connector/end_constraint"
      autoload :EndStyle, "xmi/sparx/connector/end_style"
      autoload :End, "xmi/sparx/connector/end_base"
      autoload :Source, "xmi/sparx/connector/end_base"
      autoload :Target, "xmi/sparx/connector/end_base"
      autoload :Properties, "xmi/sparx/connector/properties"
      autoload :Appearance, "xmi/sparx/connector/appearance"
      autoload :Labels, "xmi/sparx/connector/labels"
      autoload :Connector, "xmi/sparx/connector/connector"
      autoload :Connectors, "xmi/sparx/connector/connector"
    end
  end
end
