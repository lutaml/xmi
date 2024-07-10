# frozen_string_literal: true

module Xmi
  class EaRoot
    module Eauml
      class Import < Shale::Mapper
        attribute :base_package_import, Shale::Type::String

        xml do
          root "import"

          map_attribute "base_PackageImport", to: :base_package_import
        end
      end
    end
  end
end
