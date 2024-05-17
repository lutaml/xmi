require 'shale'

require_relative 'namespace'

class ModelElementnamespace < Shale::Mapper
  attribute :namespace, Namespace, collection: true

  xml do
    root 'ModelElement.namespace'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Namespace', to: :namespace
  end
end
