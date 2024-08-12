# frozen_string_literal: true

require "shale"

require_relative "create_action"

class ClassifiercreateAction < Shale::Mapper
  attribute :create_action, CreateAction, collection: true

  xml do
    root "Classifier.createAction"
    namespace "omg.org/UML1.3", "UML"

    map_element "CreateAction", to: :create_action
  end
end
