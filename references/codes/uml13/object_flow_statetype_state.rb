# frozen_string_literal: true

require "shale"

require_relative "classifier_in_state"

class ObjectFlowStatetypeState < Shale::Mapper
  attribute :classifier_in_state, ClassifierInState, collection: true

  xml do
    root "ObjectFlowState.typeState"
    namespace "omg.org/UML1.3", "UML"

    map_element "ClassifierInState", to: :classifier_in_state
  end
end
