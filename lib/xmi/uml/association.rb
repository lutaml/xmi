# frozen_string_literal: true

require_relative "packaged_element"

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:Association">`. Binary
    # link between two types, carrying ownedEnd / memberEnd children.
    class Association < PackagedElement
    end
  end
end
