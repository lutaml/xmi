# frozen_string_literal: true

require "shale"

require_relative "exception"

module Xmi
  module Uml13
    class BehavioralFeatureraisedException < Shale::Mapper
      attribute :exception, Exception, collection: true

      xml do
        root "BehavioralFeature.raisedException"
        namespace "omg.org/UML1.3", "UML"

        map_element "Exception", to: :exception
      end
    end
  end
end
