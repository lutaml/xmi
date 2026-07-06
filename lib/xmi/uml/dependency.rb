# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:Dependency">`. A relationship
    # between a client and supplier packageable element.
    #
    # Phase A of TODO.next/01: subclass is a type tag on
    # PackagedElement. The union-bag attribute set is inherited
    # unchanged so existing consumers keep working. Phase B
    # (narrowing attrs to the subclass) is future work.
    class Dependency < PackagedElement
    end
  end
end
