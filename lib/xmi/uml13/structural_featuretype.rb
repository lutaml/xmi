require 'shale'

require_relative 'classifier'

class StructuralFeaturetype < Shale::Mapper
  attribute :classifier, Classifier, collection: true

  xml do
    root 'StructuralFeature.type'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Classifier', to: :classifier
  end
end
