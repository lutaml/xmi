# frozen_string_literal: true

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:Realization">`. Generic
    # realization relationship. Note Sparx EA collapses strict
    # `<interfaceRealization>` into this generic form; see
    # InterfaceRealization for the strict-OMG form.
    class Realization < PackagedElement
    end
  end
end
