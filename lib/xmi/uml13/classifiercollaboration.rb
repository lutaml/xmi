require 'shale'

require_relative 'collaboration'

class Classifiercollaboration < Shale::Mapper
  attribute :collaboration, Collaboration, collection: true

  xml do
    root 'Classifier.collaboration'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Collaboration', to: :collaboration
  end
end
