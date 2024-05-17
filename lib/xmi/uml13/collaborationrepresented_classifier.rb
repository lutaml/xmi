require 'shale'

require_relative 'classifier'

class CollaborationrepresentedClassifier < Shale::Mapper
  attribute :classifier, Classifier, collection: true

  xml do
    root 'Collaboration.representedClassifier'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Classifier', to: :classifier
  end
end
