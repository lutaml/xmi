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
    autoload :Term, "xmi/performance/term"

    # ANSI color codes shared by Term, Helpers, Comparator, and Runner.
    CLEAR   = "\e[0m"
    BOLD    = "\e[1m"
    DIM     = "\e[2m"
    CYAN    = "\e[36m"
    GREEN   = "\e[32m"
    YELLOW  = "\e[33m"
    RED     = "\e[31m"
    GRAY    = "\e[90m"
    MAGENTA = "\e[35m"
  end
end
