require 'shale'

require_relative 'tagged_value'

class StereotyperequiredTag < Shale::Mapper
  attribute :tagged_value, TaggedValue, collection: true

  xml do
    root 'Stereotype.requiredTag'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'TaggedValue', to: :tagged_value
  end
end
