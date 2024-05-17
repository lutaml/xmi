# frozen_string_literal: true

require "shale"

module Xmi

  # OMG 1.3
  class EaXmiHeaderDocumentation < Shale::Mapper
    attribute :exporter, Shale::Type::String
    attribute :exporter_version, Shale::Type::String
    attribute :exporter_id, Shale::Type::String

    xml do
      root "XMI.documentation"

      map_element "XMI.documentation", to: :documentation
      map_element "XMI.exporterVersion", to: :exporter_version
      map_element "XMI.exporterID", to: :exporter_id
    end
  end

  # OMG 1.3
  class EaXmiHeader < Shale::Mapper
    attribute :documentation, EaXmiHeaderDocumentation
    xml do
      root "XMI.header"

      map_element "XMI.documentation", to: :documentation
    end
  end

  class Root13 < Shale::Mapper
    attribute :uml, Shale::Type::String
    attribute :timestamp, Shale::Type::String
    attribute :version, Shale::Type::String
    attribute :header, EaXmiHeader

    xml do
      map_attribute "xmlns:UML", to: :uml, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      # OMG 1.3
      map_attribute "xmi.version", to: :version
      map_attribute "timestamp", to: :timestamp
    end
  end
end
