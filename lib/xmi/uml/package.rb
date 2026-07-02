# frozen_string_literal: true

require_relative "packaged_element"

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:Package">`. Container for
    # nested packagedElement children.
    class Package < PackagedElement
    end
  end
end
