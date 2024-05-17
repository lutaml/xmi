require 'shale'

require_relative 'structural_feature'

class ClassifierstructuralFeature < Shale::Mapper
  attribute :structural_feature, StructuralFeature, collection: true

  xml do
    root 'Classifier.structuralFeature'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'StructuralFeature', to: :structural_feature
  end
end
