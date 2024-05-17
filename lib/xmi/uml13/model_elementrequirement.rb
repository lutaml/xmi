require 'shale'

require_relative 'dependency'

class ModelElementrequirement < Shale::Mapper
  attribute :dependency, Dependency, collection: true

  xml do
    root 'ModelElement.requirement'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Dependency', to: :dependency
  end
end
