# frozen_string_literal: true

module Xmi
  module Uml
    class Specification < Base
      attribute :language, :string
      attribute :content, :string

      xml do
        root "specification"
        map_attribute "language", to: :language
        map_content to: :content
      end
    end
  end
end
