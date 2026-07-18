# frozen_string_literal: true

module Xmi
  # Benchmarking and performance comparison tooling.
  #
  # Loaded on demand via autoload — never required at gem runtime.
  # The rake tasks in lib/tasks/performance.rake load this module
  # through `require "xmi"` and reference Xmi::Performance::*
  # constants.
  module Performance
    autoload :Helpers, "xmi/performance/helpers"
    autoload :Comparator, "xmi/performance/comparator"
    autoload :Runner, "xmi/performance/runner"
  end
end
