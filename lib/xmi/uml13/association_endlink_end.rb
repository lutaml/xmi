require 'shale'

require_relative 'link_end'

class AssociationEndlinkEnd < Shale::Mapper
  attribute :link_end, LinkEnd, collection: true

  xml do
    root 'AssociationEnd.linkEnd'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'LinkEnd', to: :link_end
  end
end
