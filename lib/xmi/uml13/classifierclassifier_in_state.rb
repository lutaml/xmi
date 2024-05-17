require 'shale'

require_relative 'classifier_in_state'

class ClassifierclassifierInState < Shale::Mapper
  attribute :classifier_in_state, ClassifierInState, collection: true

  xml do
    root 'Classifier.classifierInState'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'ClassifierInState', to: :classifier_in_state
  end
end
