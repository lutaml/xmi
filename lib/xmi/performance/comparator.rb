# frozen_string_literal: true

require "fileutils"

module Xmi
  module Performance
    # Orchestrates the performance comparison flow: loads the Runner
    # into Base and Current namespaces, runs both, and reports
    # regressions.
    class Comparator
      REPO_ROOT = File.expand_path(File.join(__dir__, "..", "..", ".."))
      DEFAULT_RUN_TIME = 10
      DEFAULT_THRESHOLD = 0.10 # 10% (more lenient for complex operations)
      DEFAULT_BASE = "main"

      def run
        setup_environment
        run_benchmarks_comparison
      end

      private

      def setup_environment
        Dir.chdir(REPO_ROOT)
        Helpers.load_runner_into(Helpers::Current)
        Helpers.load_runner_into(Helpers::Base)
      end

      def run_benchmarks_comparison
        all_current = {}
        all_base = {}

        puts Term.header("Performance Comparison", color: CYAN)
        puts
        puts "  #{DIM}Comparing#{CLEAR}:"
        puts "  #{CYAN}  Current#{CLEAR}: #{Helpers.current_branch}"
        puts "  #{CYAN}  Base#{CLEAR}: #{DEFAULT_BASE}"
        puts "  #{CYAN}  Threshold#{CLEAR}: #{(DEFAULT_THRESHOLD * 100).round(0)}% regression allowed"
        puts

        base_runner = Helpers::Base::Runner.new(
          run_time: DEFAULT_RUN_TIME,
        )
        current_runner = Helpers::Current::Runner.new(
          run_time: DEFAULT_RUN_TIME,
        )

        Helpers.run_benchmarks(
          base_runner,
          current_runner,
          DEFAULT_THRESHOLD,
          all_base,
          all_current,
        )

        summary = Helpers.summary_report(
          all_current,
          all_base,
          DEFAULT_BASE,
          DEFAULT_RUN_TIME,
          DEFAULT_THRESHOLD,
        )

        handle_results(summary)
      end

      def handle_results(summary)
        puts
        if summary[:regressions].any?
          puts "  #{RED}#{BOLD}❌ PERFORMANCE REGRESSIONS DETECTED#{CLEAR}"
          puts "  #{RED}#{summary[:regressions].length} benchmark(s) regressed beyond threshold#{CLEAR}"
          puts
          exit(1)
        else
          puts "  #{GREEN}#{BOLD}✅ ALL BENCHMARKS PASSED#{CLEAR}"
          puts
        end
      end
    end
  end
end
