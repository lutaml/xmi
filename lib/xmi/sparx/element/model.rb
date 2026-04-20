# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Model < Lutaml::Model::Serializable
        attribute :package, :string
        attribute :package2, :string
        attribute :tpos, :integer
        attribute :ea_localid, :string
        attribute :ea_eleType, :string

        xml do
          root "model"
          namespace ::Xmi::Namespace::Omg::Uml

          map_attribute "package", to: :package
          map_attribute "package2", to: :package2
          map_attribute "tpos", to: :tpos
          map_attribute "ea_localid", to: :ea_localid
          map_attribute "ea_eleType", to: :ea_eleType
        end
      end
    end
  end
end
