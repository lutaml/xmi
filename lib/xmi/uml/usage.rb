# frozen_string_literal: true

require_relative "packaged_element"

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:Usage">. A Dependency
    # subtype indicating that a client requires a supplier for its
    # proper functioning (UML 2.5 §19.3).
    #
    # Phase A of TODO.next/01: subclass is a type tag on
    # PackagedElement. The union-bag attribute set is inherited
    # unchanged so existing consumers keep working. Phase B
    # (narrowing attrs to the subclass) is future work.
    class Usage < PackagedElement
    end
  end
end
