require 'shale'

require_relative 'tagged_value'

class ModelElementtaggedValue < Shale::Mapper
  attribute :tagged_value, TaggedValue, collection: true

  xml do
    root 'ModelElement.taggedValue'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'TaggedValue', to: :tagged_value
  end
end
