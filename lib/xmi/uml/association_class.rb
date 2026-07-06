# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:AssociationClass">`. An
    # association that is also a class (UML 2.5 §11.4).
    #
    # Phase A of TODO.next/01: subclass is a type tag on
    # PackagedElement. The union-bag attribute set is inherited
    # unchanged so existing consumers keep working. Phase B
    # (narrowing attrs to the subclass) is future work.
    class AssociationClass < PackagedElement
    end
  end
end
