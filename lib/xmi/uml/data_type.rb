# frozen_string_literal: true

require_relative "packaged_element"

module Xmi
  module Uml
    # UML `<packagedElement xmi:type="uml:DataType">`. Classifier
    # for type definitions (e.g. record shapes).
    class DataType < PackagedElement
    end
  end
end
