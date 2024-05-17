require 'shale'

require_relative 'classifier'

class Classifierspecification < Shale::Mapper
  attribute :classifier, Classifier, collection: true

  xml do
    root 'Classifier.specification'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Classifier', to: :classifier
  end
end
