require 'shale'

require_relative 'collaboration'

class AssociationRolenamespace < Shale::Mapper
  attribute :collaboration, Collaboration, collection: true

  xml do
    root 'AssociationRole.namespace'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Collaboration', to: :collaboration
  end
end
