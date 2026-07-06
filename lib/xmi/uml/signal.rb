# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:Signal">`. A signal is a
    # classifier that communicates the sending of a message instance
    # (UML 2.5 §17.4).
    #
    # Phase A of TODO.next/01: subclass is a type tag on
    # PackagedElement. The union-bag attribute set is inherited
    # unchanged so existing consumers keep working. Phase B
    # (narrowing attrs to the subclass) is future work.
    class Signal < PackagedElement
    end
  end
end
