# frozen_string_literal: true

require "shale"

require_relative "link_end"

class LinklinkRole < Shale::Mapper
  attribute :link_end, LinkEnd, collection: true

  xml do
    root "Link.linkRole"
    namespace "omg.org/UML1.3", "UML"

    map_element "LinkEnd", to: :link_end
  end
end
