require 'shale'

require_relative 'model_element'

class ModelElementtemplateParameter < Shale::Mapper
  attribute :model_element, ModelElement, collection: true

  xml do
    root 'ModelElement.templateParameter'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'ModelElement', to: :model_element
  end
end
