# frozen_string_literal: true

module Xmi
  # UML Diagram Interchange (UMLDI) classes. Parallel to Xmi::Uml
  # but in the UMLDI namespace (http://www.omg.org/spec/UML/20131001/UMLDI).
  # Used for diagram elements: Bounds, Waypoint, Diagram, OwnedElement.
  module UmlDi
    autoload :Base, "xmi/uml_di/base"
  end
end
