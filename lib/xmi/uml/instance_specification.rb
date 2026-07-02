# frozen_string_literal: true

require_relative "packaged_element"

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:InstanceSpecification">`.
    # A named instance of a classifier, carrying slot children that
    # hold the instance's values for each defining feature.
    class InstanceSpecification < PackagedElement
    end
  end
end
