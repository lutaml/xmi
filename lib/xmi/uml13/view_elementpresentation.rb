require 'shale'

require_relative 'presentation'

class ViewElementpresentation < Shale::Mapper
  attribute :presentation, Presentation, collection: true

  xml do
    root 'ViewElement.presentation'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Presentation', to: :presentation
  end
end
