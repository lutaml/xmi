# frozen_string_literal: true

module Xmi
  module Sparx
    module Element
      class Properties < Lutaml::Model::Serializable
        attribute :name, :string
        attribute :type, ::Xmi::Type::XmiType
        attribute :is_specification, :boolean
        attribute :is_root, :boolean
        attribute :is_leaf, :boolean
        attribute :is_abstract, :boolean
        attribute :is_active, :boolean
        attribute :s_type, :string
        attribute :n_type, :string
        attribute :scope, :string
        attribute :stereotype, :string
        attribute :alias, :string
        attribute :documentation, :string

        xml do
          root "properties"

          map_attribute "name", to: :name
          map_attribute "type", to: :type
          map_attribute "isSpecification", to: :is_specification
          map_attribute "isRoot", to: :is_root
          map_attribute "isLeaf", to: :is_leaf
          map_attribute "isAbstract", to: :is_abstract
          map_attribute "isActive", to: :is_active
          map_attribute "sType", to: :s_type
          map_attribute "nType", to: :n_type
          map_attribute "scope", to: :scope
          map_attribute "stereotype", to: :stereotype
          map_attribute "alias", to: :alias
          map_attribute "documentation", to: :documentation
        end
      end
    end
  end
end
