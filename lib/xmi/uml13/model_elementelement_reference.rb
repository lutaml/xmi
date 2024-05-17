require 'shale'

require_relative 'element_reference'

class ModelElementelementReference < Shale::Mapper
  attribute :element_reference, ElementReference, collection: true

  xml do
    root 'ModelElement.elementReference'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'ElementReference', to: :element_reference
  end
end
