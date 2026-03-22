# frozen_string_literal: true

require "benchmark/ips"

# Ensure lib/ is on the load path regardless of tmp location
lib_path = File.expand_path(File.join(__dir__, "..", "..", "lib"))
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

require "xmi"

# Pretty terminal formatting for benchmark output
module Term
  CLEAR   = "\e[0m"
  BOLD    = "\e[1m"
  DIM     = "\e[2m"
  RED     = "\e[31m"
  GREEN   = "\e[32m"
  YELLOW  = "\e[33m"
  CYAN    = "\e[36m"
  MAGENTA = "\e[35m"

  HL = "─"
  VL = "│"
  TL = "┌"
  TR = "┐"
  BL = "└"
  BR = "┘"

  def self.header(title, color: CYAN)
    width = 78
    line = HL * width
    puts
    puts "#{color}#{TL}#{line}#{TR}#{CLEAR}"
    puts "#{color}#{VL}#{CLEAR}  #{BOLD}#{color}#{title}#{CLEAR}#{' ' * (width - title.length - 4)}#{color}#{VL}#{CLEAR}"
    puts "#{color}#{BL}#{line}#{BR}#{CLEAR}"
  end

  def self.sep(char: HL, width: 78)
    puts "#{DIM}#{char * width}#{CLEAR}"
  end

  def self.env_info(ruby_version, platform)
    puts
    puts "  #{DIM}Environment:#{CLEAR}"
    puts "  #{VL}  Ruby #{ruby_version} on #{platform}#{' ' * (60 - ruby_version.length - platform.length)}#{VL}"
    puts "  #{DIM}#{BL}#{HL * 76}#{BR}#{CLEAR}"
    puts
  end

  def self.category(title, icon:, description:, failure_means:,
compare_against: nil)
    puts
    puts "#{CYAN}#{VL}#{CLEAR}  #{BOLD}#{MAGENTA}#{icon} #{title}#{CLEAR}"
    puts
    puts "  #{DIM}#{description}#{CLEAR}"
    puts

    if compare_against
      puts "  #{CYAN}Comparing against:#{CLEAR} #{compare_against}"
      puts
    end

    puts "  #{YELLOW}⚠️  Failure means:#{CLEAR} #{failure_means}"
    puts
    sep(width: 76)
    puts
  end
end

class BenchmarkRunner
  REPO_ROOT = File.expand_path(File.join(__dir__, "..", ".."))

  # Benchmark configuration
  DEFAULT_RUN_TIME = 5
  DEFAULT_WARMUP = 2

  # Category definitions with descriptions
  CATEGORIES = {
    xmi_parsing: {
      name: "XMI Parsing",
      icon: "📄",
      description: "XMI parsing performance tests. Measures how quickly we can convert XMI files into Ruby objects.",
      failure_means: "Slow XMI parsing impacts all downstream operations. A regression here means users will experience delays when processing XMI documents.",
      compare_against: "Previous branch (main).",
    },
  }.freeze

  # Test definitions
  BENCHMARKS = {
    xmi_parsing: [
      { name: "XMI 2.4.2 (small)", method: :xmi_parse_242_small,
        desc: "XMI 2.4.2 ~100KB file" },
      { name: "XMI 2.4.2 (medium)", method: :xmi_parse_242_medium,
        desc: "XMI 2.4.2 ~500KB file with extensions" },
      { name: "XMI 2.4.2 (large)", method: :xmi_parse_242_large,
        desc: "XMI 2.4.2 ~3.5MB file" },
      { name: "XMI 2.5.1", method: :xmi_parse_251,
        desc: "XMI 2.5.1 ~100KB file" },
    ],
  }.freeze

  # Test data - fixture paths
  FIXTURES = {
    xmi_parse_242_small: "spec/fixtures/xmi-v2-4-2-default.xmi",
    xmi_parse_242_medium: "spec/fixtures/xmi-v2-4-2-default-with-citygml.xmi",
    xmi_parse_242_large: "spec/fixtures/full-242.xmi",
    xmi_parse_251: "spec/fixtures/ea-xmi-2.5.1.xmi",
  }.freeze

  def initialize(run_time: nil, warmup: nil, benchmark: nil)
    @run_time = run_time || DEFAULT_RUN_TIME
    @warmup = warmup || DEFAULT_WARMUP
    @benchmark = benchmark
    @results = {}
    @env_shown = false
    @all_results = []
  end

  def run_benchmarks
    Term.header("XMI Performance Benchmarks", color: Term::CYAN)

    unless @env_shown
      Term.env_info(RUBY_VERSION, RUBY_PLATFORM)
      @env_shown = true
    end

    BENCHMARKS.each do |category, tests|
      run_category(category, tests)
    end

    print_summary

    @results
  end

  private

  def run_category(category, tests)
    config = CATEGORIES[category]
    Term.category(
      config[:name],
      icon: config[:icon],
      description: config[:description],
      failure_means: config[:failure_means],
      compare_against: config[:compare_against],
    )

    category_results = []

    tests.each do |test|
      # Redirect stdout during benchmark
      original_stdout = $stdout
      $stdout = StringIO.new

      result = run_single_test(test[:method])
      (result[:lower] + result[:upper]) / 2.0
      category_results << { name: test[:name], result: result }

      # Restore stdout
      $stdout = original_stdout
    end

    # Print results
    puts "  #{'Benchmark'.ljust(40)} #{'IPS'.rjust(12)} #{'Deviation'.rjust(12)}"
    puts "  #{Term::DIM}#{Term::HL * 66}#{Term::CLEAR}"

    category_results.each do |r|
      ips = (r[:result][:lower] + r[:result][:upper]) / 2.0
      deviation = calculate_deviation(r[:result])
      label = "#{config[:name]}: #{r[:name]}"
      @all_results << { label: label, ips: ips }
      @results[label] = r[:result]

      puts "  #{r[:name].ljust(40)} #{format('%.2f',
                                             ips).rjust(12)} #{format('%.1f%%',
                                                                      deviation).rjust(12)}"
    end

    puts
  end

  def run_single_test(method)
    fixture_path = FIXTURES[method]
    raise "Unknown fixture: #{method}" unless fixture_path

    # Try to resolve fixture path relative to REPO_ROOT
    full_path = File.join(REPO_ROOT, fixture_path)
    unless File.exist?(full_path)
      # Fallback: try current directory
      full_path = fixture_path
    end

    xml_content = File.read(full_path)

    case method
    when :xmi_parse_242_small, :xmi_parse_242_medium, :xmi_parse_242_large, :xmi_parse_251
      measure_time { Xmi::Sparx::SparxRoot.parse_xml(xml_content) }
    else
      raise "Unknown benchmark: #{method}"
    end
  end

  def measure(&)
    job = Benchmark::IPS::Job.new
    job.config(time: @run_time, warmup: @warmup)
    job.report("test", &)
    job.run

    entry = job.full_report.entries.first
    samples = entry.stats.samples

    return { lower: 0, upper: 0 } if samples.empty?

    mean = samples.sum.to_f / samples.size
    variance = samples.sum { |x| (x - mean)**2 } / (samples.size - 1)
    std_dev = Math.sqrt(variance)
    error_margin = std_dev / mean
    error_pct = error_margin.round(4)

    { lower: mean.round(4) * (1 - error_pct),
      upper: mean.round(4) * (1 + error_pct) }
  end

  def measure_time
    times = []
    iterations = 5

    iterations.times do
      start_t = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      yield
      finish_t = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      times << (finish_t - start_t)
    end

    mean = times.sum / times.size
    variance = times.sum { |t| (t - mean)**2 } / (times.size - 1)
    std_dev = Math.sqrt(variance)

    # Use conservative estimates for time-based measurement
    lower_time = [mean - std_dev, mean * 0.5].max
    lower_ips = (1.0 / (lower_time * 1.5)).round(4)
    upper_ips = (1.0 / mean).round(4)

    # For fast operations, estimate more conservatively
    if mean < 0.001
      upper_ips = (1.0 / mean).round(4)
      lower_ips = (upper_ips * 0.8).round(4)
    end

    { lower: lower_ips, upper: upper_ips }
  end

  def calculate_deviation(metrics)
    return 0 if metrics[:upper].zero?

    ((metrics[:upper] - metrics[:lower]) / metrics[:upper] * 100).round(1)
  end

  def print_summary
    puts
    Term.sep(width: 78)
    puts
    puts "  #{Term::BOLD}#{Term::MAGENTA}SUMMARY#{Term::CLEAR}"
    puts

    @all_results.each do |r|
      puts "  #{r[:label].ljust(60)} #{format('%.2f', r[:ips]).rjust(10)} IPS"
    end

    puts
    puts "  #{Term::DIM}#{@all_results.length} benchmarks completed#{Term::CLEAR}"
    puts
  end
end
