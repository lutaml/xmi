require 'shale'

require_relative 'attribute'
require_relative 'behavioral_feature'
require_relative 'feature'
require_relative 'method'
require_relative 'operation'
require_relative 'reception'
require_relative 'structural_feature'

class Classifierfeature < Shale::Mapper
  attribute :feature, Feature, collection: true
  attribute :structural_feature, StructuralFeature, collection: true
  attribute :behavioral_feature, BehavioralFeature, collection: true
  attribute :attribute, Attribute, collection: true
  attribute :operation, Operation, collection: true
  attribute :method, Method, collection: true
  attribute :reception, Reception, collection: true

  xml do
    root 'Classifier.feature'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Feature', to: :feature
    map_element 'StructuralFeature', to: :structural_feature
    map_element 'BehavioralFeature', to: :behavioral_feature
    map_element 'Attribute', to: :attribute
    map_element 'Operation', to: :operation
    map_element 'Method', to: :method
    map_element 'Reception', to: :reception
  end
end
