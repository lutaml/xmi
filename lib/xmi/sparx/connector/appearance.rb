# frozen_string_literal: true

module Xmi
  module Sparx
    module Connector
      class Appearance < Lutaml::Model::Serializable
        skip_reference_registration
        attribute :linemode, :integer
        attribute :linecolor, :integer
        attribute :linewidth, :integer
        attribute :seqno, :integer
        attribute :headStyle, :integer
        attribute :lineStyle, :integer

        xml do
          root "appearance"
          namespace ::Xmi::Namespace::Omg::Xmi

          map_attribute :linemode, to: :linemode
          map_attribute :linecolor, to: :linecolor
          map_attribute :linewidth, to: :linewidth
          map_attribute :seqno, to: :seqno
          map_attribute :headStyle, to: :headStyle
          map_attribute :lineStyle, to: :lineStyle
        end
      end
    end
  end
end
