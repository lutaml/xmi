# frozen_string_literal: true

require "shale"

require_relative "link"

class LinkEndlink < Shale::Mapper
  attribute :link, Link, collection: true

  xml do
    root "LinkEnd.link"
    namespace "omg.org/UML1.3", "UML"

    map_element "Link", to: :link
  end
end
