# frozen_string_literal: true

require "shale"

require_relative "request"

class MessageInstancespecification < Shale::Mapper
  attribute :request, Request, collection: true

  xml do
    root "MessageInstance.specification"
    namespace "omg.org/UML1.3", "UML"

    map_element "Request", to: :request
  end
end
