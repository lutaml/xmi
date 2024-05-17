require 'shale'

require_relative 'attribute'

class AttributeLinkattribute < Shale::Mapper
  attribute :attribute, Attribute, collection: true

  xml do
    root 'AttributeLink.attribute'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Attribute', to: :attribute
  end
end
