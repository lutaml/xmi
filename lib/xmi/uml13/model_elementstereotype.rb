require 'shale'

require_relative 'stereotype'

class ModelElementstereotype < Shale::Mapper
  attribute :stereotype, Stereotype, collection: true

  xml do
    root 'ModelElement.stereotype'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Stereotype', to: :stereotype
  end
end
