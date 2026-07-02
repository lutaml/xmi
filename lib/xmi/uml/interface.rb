# frozen_string_literal: true

require_relative "packaged_element"

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:Interface">`. Contract
    # declaration carrying owned_operation children.
    class Interface < PackagedElement
    end
  end
end
