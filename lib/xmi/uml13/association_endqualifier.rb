require 'shale'

require_relative 'attribute'

class AssociationEndqualifier < Shale::Mapper
  attribute :attribute, Attribute, collection: true

  xml do
    root 'AssociationEnd.qualifier'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Attribute', to: :attribute
  end
end
