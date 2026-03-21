# frozen_string_literal: true

require "lutaml/model"
require "lutaml/xml"

# Configure XML adapter
Lutaml::Model::Config.xml_adapter_type = :nokogiri

module Lutaml
  module Model
    class Serializable
      def type?(test_type)
        !!type ? type == test_type : false
      end
    end
  end
end

require_relative "xmi/version"
require_relative "xmi/namespace"
require_relative "xmi/namespace/dynamic"
require_relative "xmi/type"
require_relative "xmi/namespace_detector"
require_relative "xmi/namespace_registry"

module Xmi
  class Error < StandardError; end

  # Shared value_map for XMI elements
  # Used to handle nil, empty, and omitted values consistently
  VALUE_MAP = {
    from: { nil: :empty, empty: :empty, omitted: :empty },
    to: { nil: :empty, empty: :empty, omitted: :empty },
  }.freeze
end

# Bootstrap the namespace registry
Xmi::NamespaceRegistry.bootstrap!

require_relative "xmi/add"
require_relative "xmi/delete"
require_relative "xmi/difference"
require_relative "xmi/documentation"
require_relative "xmi/extension"
require_relative "xmi/replace"
require_relative "xmi/ea_root"
require_relative "xmi/uml"
require_relative "xmi/custom_profile"
require_relative "xmi/root"
require_relative "xmi/sparx"

# Backward compatibility aliases - Gml moved to Xmi::Sparx::Gml
Xmi::EaRoot::Gml = Xmi::Sparx::Gml
# Backward compatibility aliases - Eauml moved to Xmi::Sparx::EaUml
Xmi::EaRoot::Eauml = Xmi::Sparx::EaUml
