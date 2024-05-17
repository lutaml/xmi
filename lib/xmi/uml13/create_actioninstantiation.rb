require 'shale'

require_relative 'classifier'

class CreateActioninstantiation < Shale::Mapper
  attribute :classifier, Classifier, collection: true

  xml do
    root 'CreateAction.instantiation'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Classifier', to: :classifier
  end
end
