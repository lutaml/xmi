# frozen_string_literal: true

require_relative "performance_helpers"

class PerformanceComparator
  REPO_ROOT = File.expand_path(File.join(__dir__, "..", ".."))
  DEFAULT_RUN_TIME = 10
  DEFAULT_THRESHOLD = 0.10 # 10% (more lenient for complex operations)
  DEFAULT_BASE = "main"
  TMP_PERF_DIR = File.join(REPO_ROOT, "tmp", "performance")
  BENCH_SCRIPT = File.join(TMP_PERF_DIR, "benchmark_runner.rb")

  def run
    setup_environment
    run_benchmarks_comparison
  ensure
    cleanup
  end

  private

  def setup_environment
    Dir.chdir(REPO_ROOT)
    FileUtils.mkdir_p(TMP_PERF_DIR)
    FileUtils.cp(File.join(REPO_ROOT, "lib", "tasks", "benchmark_runner.rb"),
                 BENCH_SCRIPT)

    PerformanceHelpers.load_into_namespace(PerformanceHelpers::Current,
                                           BENCH_SCRIPT)
    PerformanceHelpers.clone_base_repo(DEFAULT_BASE, TMP_PERF_DIR, BENCH_SCRIPT)
  end

  def run_benchmarks_comparison
    all_current = {}
    all_base = {}

    puts PerformanceHelpers::Term.header("Performance Comparison", color: PerformanceHelpers::CYAN)
    puts
    puts "  #{PerformanceHelpers::DIM}Comparing#{PerformanceHelpers::CLEAR}:"
    puts "  #{PerformanceHelpers::CYAN}  Current#{PerformanceHelpers::CLEAR}: #{PerformanceHelpers.current_branch}"
    puts "  #{PerformanceHelpers::CYAN}  Base#{PerformanceHelpers::CLEAR}: #{DEFAULT_BASE}"
    puts "  #{PerformanceHelpers::CYAN}  Threshold#{PerformanceHelpers::CLEAR}: #{(DEFAULT_THRESHOLD * 100).round(0)}% regression allowed"
    puts

    # Run all benchmarks
    base_runner = PerformanceHelpers::Base::BenchmarkRunner.new(
      run_time: DEFAULT_RUN_TIME,
    )
    current_runner = PerformanceHelpers::Current::BenchmarkRunner.new(
      run_time: DEFAULT_RUN_TIME,
    )

    PerformanceHelpers.run_benchmarks(
      base_runner,
      current_runner,
      DEFAULT_THRESHOLD,
      all_base,
      all_current,
    )

    summary = PerformanceHelpers.summary_report(
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
      puts "  #{PerformanceHelpers::RED}#{PerformanceHelpers::BOLD}❌ PERFORMANCE REGRESSIONS DETECTED#{PerformanceHelpers::CLEAR}"
      puts "  #{PerformanceHelpers::RED}#{summary[:regressions].length} benchmark(s) regressed beyond threshold#{PerformanceHelpers::CLEAR}"
      puts
      exit(1)
    else
      puts "  #{PerformanceHelpers::GREEN}#{PerformanceHelpers::BOLD}✅ ALL BENCHMARKS PASSED#{PerformanceHelpers::CLEAR}"
      puts
    end
  end

  def cleanup
    FileUtils.rm_rf(TMP_PERF_DIR)
  end
end
