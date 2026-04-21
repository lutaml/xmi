# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Performance Benchmarks" do
  # Performance regression thresholds
  # Allow 20% regression before failing (conservative for CI)
  REGRESSION_THRESHOLD = 0.20

  # Minimum iterations for reliable measurement
  MIN_ITERATIONS = 3

  # Fixture root - works from both project root and spec directory
  FIXTURE_ROOT = File.expand_path("../..", __dir__)

  # Baseline performance values (IPS = iterations per second)
  # These were measured on the main branch
  # Format: { fixture_name: { iterations: X, mean_time: Y, std_dev: Z } }
  BASELINE_PERFORMANCE = {
    # XMI 2.4.2 small (~100KB)
    xmi_parse_242_small: { ips: 1.0, min_ips: 0.8 },
    # XMI 2.4.2 medium with extensions (~500KB)
    xmi_parse_242_medium: { ips: 1.0, min_ips: 0.8 },
    # XMI 2.4.2 large (~3.5MB)
    xmi_parse_242_large: { ips: 0.1, min_ips: 0.08 },
    # XMI 2.5.1 (~100KB)
    xmi_parse_251: { ips: 3.0, min_ips: 2.4 },
  }.freeze

  # Fixture paths
  FIXTURES = {
    xmi_parse_242_small: "spec/fixtures/xmi-v2-4-2-default.xmi",
    xmi_parse_242_medium: "spec/fixtures/xmi-v2-4-2-default-with-citygml.xmi",
    xmi_parse_242_large: "spec/fixtures/full-242.xmi",
    xmi_parse_251: "spec/fixtures/ea-xmi-2.5.1.xmi",
  }.freeze

  def measure_parsing_time(fixture_path)
    xml_content = File.read(File.join(FIXTURE_ROOT, fixture_path))

    times = []
    iterations = 5

    iterations.times do
      GC.start
      t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      Xmi::Sparx::Root.parse_xml(xml_content)
      t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      times << (t1 - t0)
    end

    {
      times: times,
      mean: times.sum / times.size,
      min: times.min,
      max: times.max,
      std_dev: Math.sqrt(times.sum do |t|
        (t - (times.sum / times.size))**2
      end / times.size),
    }
  end

  def times_to_ips(mean_time)
    return 0 if mean_time.zero?

    1.0 / mean_time
  end

  context "with XMI 2.4.2 small fixture" do
    subject(:benchmark) do
      measure_parsing_time(FIXTURES[:xmi_parse_242_small])
    end

    it "completes within acceptable time" do
      expect(benchmark[:mean]).to be < 2.0 # Should complete in under 2 seconds
    end

    it "has consistent performance (low variance)" do
      cv = benchmark[:std_dev] / benchmark[:mean] if benchmark[:mean] > 0
      expect(cv).to be < 0.5 if cv # Coefficient of variation < 50%
    end
  end

  context "with XMI 2.4.2 medium fixture" do
    subject(:benchmark) do
      measure_parsing_time(FIXTURES[:xmi_parse_242_medium])
    end

    it "completes within acceptable time" do
      expect(benchmark[:mean]).to be < 2.0
    end

    it "has consistent performance" do
      cv = benchmark[:std_dev] / benchmark[:mean] if benchmark[:mean] > 0
      expect(cv).to be < 0.5 if cv
    end
  end

  context "with XMI 2.4.2 large fixture" do
    subject(:benchmark) do
      measure_parsing_time(FIXTURES[:xmi_parse_242_large])
    end

    it "completes within acceptable time" do
      # Large fixture can take up to 15 seconds
      expect(benchmark[:mean]).to be < 15.0
    end

    it "has consistent performance" do
      cv = benchmark[:std_dev] / benchmark[:mean] if benchmark[:mean] > 0
      expect(cv).to be < 0.5 if cv
    end
  end

  context "with XMI 2.5.1 fixture" do
    subject(:benchmark) do
      measure_parsing_time(FIXTURES[:xmi_parse_251])
    end

    it "completes within acceptable time" do
      expect(benchmark[:mean]).to be < 1.0
    end

    it "has consistent performance" do
      cv = benchmark[:std_dev] / benchmark[:mean] if benchmark[:mean] > 0
      expect(cv).to be < 0.5 if cv
    end
  end

  describe "performance regression detection" do
    # This test is marked as pending by default since it requires
    # baseline measurements from the main branch
    # Run with PERF_CHECK=true to enable regression detection
    context "when PERF_CHECK environment variable is set" do
      before do
        skip "PERF_CHECK not set - skipping regression detection" unless ENV["PERF_CHECK"]
      end

      BASELINE_PERFORMANCE.each do |fixture, baseline|
        context "with #{fixture}" do
          subject(:benchmark) do
            measure_parsing_time(FIXTURES[fixture])
          end

          let(:current_ips) { times_to_ips(benchmark[:mean]) }

          it "does not regress compared to baseline" do
            min_allowed = baseline[:min_ips]
            expect(current_ips).to be >= min_allowed,
                                   "Performance regression detected for #{fixture}: " \
                                   "#{current_ips.round(2)} IPS (baseline: #{baseline[:ips]} IPS, " \
                                   "minimum allowed: #{min_allowed} IPS)"
          end
        end
      end
    end
  end
end
