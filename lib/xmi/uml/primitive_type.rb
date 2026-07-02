# frozen_string_literal: true

require_relative "packaged_element"

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:PrimitiveType">`.
    # Built-in primitive (string, integer, boolean, etc.).
    class PrimitiveType < PackagedElement
    end
  end
end
