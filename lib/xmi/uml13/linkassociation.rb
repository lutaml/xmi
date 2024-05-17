require 'shale'

require_relative 'association'

class Linkassociation < Shale::Mapper
  attribute :association, Association, collection: true

  xml do
    root 'Link.association'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Association', to: :association
  end
end
