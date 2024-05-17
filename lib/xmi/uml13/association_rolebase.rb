require 'shale'

require_relative 'association'

class AssociationRolebase < Shale::Mapper
  attribute :association, Association, collection: true

  xml do
    root 'AssociationRole.base'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Association', to: :association
  end
end
