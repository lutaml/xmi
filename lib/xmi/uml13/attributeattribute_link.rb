require 'shale'

require_relative 'attribute_link'

class AttributeattributeLink < Shale::Mapper
  attribute :attribute_link, AttributeLink, collection: true

  xml do
    root 'Attribute.attributeLink'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'AttributeLink', to: :attribute_link
  end
end
