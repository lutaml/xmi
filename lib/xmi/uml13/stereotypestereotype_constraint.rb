require 'shale'

require_relative 'constraint'

class StereotypestereotypeConstraint < Shale::Mapper
  attribute :constraint, Constraint, collection: true

  xml do
    root 'Stereotype.stereotypeConstraint'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Constraint', to: :constraint
  end
end
