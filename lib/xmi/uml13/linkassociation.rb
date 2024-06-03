# frozen_string_literal: true

require "shale"

require_relative "association"

module Xmi
  module Uml13
    class Linkassociation < Shale::Mapper
      attribute :association, Association, collection: true

      xml do
        root "Link.association"
        namespace "omg.org/UML1.3", "UML"

        map_element "Association", to: :association
      end
    end
  end
end
