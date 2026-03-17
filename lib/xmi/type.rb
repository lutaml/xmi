# frozen_string_literal: true

require_relative "namespace"

module Xmi
  module Type
    class XmiIdRef < Lutaml::Model::Type::String
      xml do
        namespace ::Xmi::Namespace::Omg::Xmi
      end
    end

    class XmiId < Lutaml::Model::Type::String
      xml do
        namespace ::Xmi::Namespace::Omg::Xmi
      end
    end

    class XmiType < Lutaml::Model::Type::String
      xml do
        namespace ::Xmi::Namespace::Omg::Xmi
      end
    end

    class XmiUuid < Lutaml::Model::Type::String
      xml do
        namespace ::Xmi::Namespace::Omg::Xmi
      end
    end

    class XmiLabel < Lutaml::Model::Type::String
      xml do
        namespace ::Xmi::Namespace::Omg::Xmi
      end
    end
  end
end
