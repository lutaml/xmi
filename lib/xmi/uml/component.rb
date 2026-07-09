# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:Component">`. Modular unit
    # of structure and behavior (UML 2.5 §12.3). Carries the same
    # child-element surface as UmlClass — owned_attribute,
    # owned_operation, owned_comment, generalization,
    # interface_realization — but signals a different deployment role
    # to consumers.
    #
    # Phase A of TODO.next/01: subclass is a type tag on
    # PackagedElement. The union-bag attribute set is inherited
    # unchanged so existing consumers keep working.
    class Component < PackagedElement
    end
  end
end
