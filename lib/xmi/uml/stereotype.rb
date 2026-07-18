# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:Stereotype">. A stereotype
    # is a kind of class defined to extend the UML metamodel
    # (UML 2.5 §22.3).
    #
    # Phase A: subclass is a type tag on
    # PackagedElement. The union-bag attribute set is inherited
    # unchanged so existing consumers keep working. Phase B
    # (narrowing attrs to the subclass) is future work.
    class Stereotype < PackagedElement
    end
  end
end
