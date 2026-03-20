# frozen_string_literal: true

# Benchmark script for XMI parsing performance.
# Usage: bundle exec ruby benchmark_parse.rb
#
# Parses the full-242.xmi fixture (3.5 MB) multiple times and reports
# average, min, and max parse times.

require "bundler/setup"
require "xmi"

FIXTURE_PATH = File.join(__dir__, "spec", "fixtures", "full-242.xmi")
WARMUP_RUNS = 2
BENCH_RUNS = 5

abort "Fixture not found: #{FIXTURE_PATH}" unless File.exist?(FIXTURE_PATH)

xml_content = File.read(FIXTURE_PATH)
file_size_mb = File.size(FIXTURE_PATH).to_f / (1024 * 1024)

puts "XMI Parsing Benchmark"
puts "=" * 50
puts "File: #{FIXTURE_PATH}"
puts "Size: #{file_size_mb.round(2)} MB"
puts "Ruby: #{RUBY_VERSION} (#{RUBY_PLATFORM})"
puts "Warmup runs: #{WARMUP_RUNS}"
puts "Benchmark runs: #{BENCH_RUNS}"
puts

# Warmup
puts "Warming up..."
WARMUP_RUNS.times do |i|
  GC.start
  Xmi::Sparx::SparxRoot.parse_xml(xml_content)
  puts "  Warmup #{i + 1}/#{WARMUP_RUNS} complete"
end

# Benchmark
puts "Benchmarking..."
times = BENCH_RUNS.times.map do |i|
  GC.start
  t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  Xmi::Sparx::SparxRoot.parse_xml(xml_content)
  t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  elapsed = t1 - t0
  puts "  Run #{i + 1}/#{BENCH_RUNS}: #{elapsed.round(3)}s"
  elapsed
end

avg = times.sum / times.size
min = times.min
max = times.max

puts
puts "Results"
puts "-" * 50
puts "Average: #{avg.round(3)} s"
puts "Min:     #{min.round(3)} s"
puts "Max:     #{max.round(3)} s"
puts "StdDev:  #{Math.sqrt(times.sum { |t| (t - avg)**2 } / times.size).round(3)} s"
