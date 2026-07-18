# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:Extension">`. An extension
    # associates a stereotype with a metaclass to make the stereotype
    # applicable to instances of that metaclass (UML 2.5 §22.3).
    #
    # Phase A: subclass is a type tag on
    # PackagedElement. The union-bag attribute set is inherited
    # unchanged so existing consumers keep working. Phase B
    # (narrowing attrs to the subclass) is future work.
    class Extension < PackagedElement
    end
  end
end
