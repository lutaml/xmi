# frozen_string_literal: true

require "shale"

require_relative "request"

module Xmi
  module Uml13
    class Actionrequest < Shale::Mapper
      attribute :request, Request, collection: true

      xml do
        root "Action.request"
        namespace "omg.org/UML1.3", "UML"

        map_element "Request", to: :request
      end
    end
  end
end
