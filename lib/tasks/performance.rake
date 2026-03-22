# frozen_string_literal: true

require_relative "performance_comparator"
require_relative "benchmark_runner"

desc "Run performance benchmarks"
namespace :performance do
  desc "Compare performance of current branch against base branch (default: main)"
  task :compare do
    PerformanceComparator.new.run
  end

  desc "Run benchmarks on current branch only (for development)"
  task :run do
    runner = BenchmarkRunner.new(run_time: 5)
    runner.run_benchmarks
  end

  desc "Quick benchmark run (faster, less accurate)"
  task :quick do
    runner = BenchmarkRunner.new(run_time: 2, warmup: 1)
    runner.run_benchmarks
  end

  desc "Run benchmarks and output as JSON"
  task :json do
    require "json"
    runner = BenchmarkRunner.new(run_time: 5)

    # Suppress pretty output, just get results
    results = runner.send(:run_benchmarks)

    output = results.each_with_object({}) do |(label, metrics), h|
      ips = (metrics[:lower] + metrics[:upper]) / 2.0
      deviation = ((metrics[:upper] - metrics[:lower]) / metrics[:upper] * 100).round(1)
      h[label] = {
        ips: ips.round(2),
        lower: metrics[:lower].round(2),
        upper: metrics[:upper].round(2),
        deviation: deviation,
      }
    end

    puts JSON.pretty_generate(output)
  end
end
