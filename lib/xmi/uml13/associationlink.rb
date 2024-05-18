# frozen_string_literal: true

require "shale"

require_relative "link"

module Xmi
  module Uml13
    class Associationlink < Shale::Mapper
      attribute :link, Link, collection: true

      xml do
        root "Association.link"
        namespace "omg.org/UML1.3", "UML"

        map_element "Link", to: :link
      end
    end
  end
end
