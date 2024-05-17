require 'shale'

require_relative 'association_role'

class AssociationEndRoleassociationRole < Shale::Mapper
  attribute :association_role, AssociationRole, collection: true

  xml do
    root 'AssociationEndRole.associationRole'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'AssociationRole', to: :association_role
  end
end
