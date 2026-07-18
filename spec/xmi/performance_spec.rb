# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Verifies the Xmi::Performance namespace is properly autoloaded and
# the dual-namespace Runner cloning mechanism works. The rake tasks
# in lib/tasks/performance.rake depend on these contracts.
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "Xmi::Performance namespace" do
  describe "autoload" do
    it "exposes Comparator via autoload" do
      expect(Xmi::Performance::Comparator).to be_a(Class)
    end

    it "exposes Helpers via autoload" do
      expect(Xmi::Performance::Helpers).to be_a(Module)
    end

    it "exposes Runner via autoload" do
      expect(Xmi::Performance::Runner).to be_a(Class)
    end

    it "Runner inherits nothing surprising — it is a standalone class" do
      expect(Xmi::Performance::Runner.superclass).to eq(Object)
    end
  end

  describe "Helpers.load_runner_into" do
    it "clones Runner into the target namespace as ::Runner" do
      target = Module.new
      Xmi::Performance::Helpers.load_runner_into(target)
      expect(target.const_defined?(:Runner, false)).to be(true)
      expect(target::Runner).to eq(target.const_get(:Runner))
    end

    it "the cloned Runner is a distinct class object from the original" do
      target = Module.new
      Xmi::Performance::Helpers.load_runner_into(target)
      expect(target::Runner).not_to equal(Xmi::Performance::Runner)
      # Clone has the same public methods (run_benchmarks etc.)
      expect(target::Runner.instance_methods).to include(:run_benchmarks)
    end

    it "Base and Current namespaces each get their own Runner clone" do
      Xmi::Performance::Helpers.load_runner_into(Xmi::Performance::Helpers::Base)
      Xmi::Performance::Helpers.load_runner_into(Xmi::Performance::Helpers::Current)
      expect(Xmi::Performance::Helpers::Base::Runner)
        .not_to equal(Xmi::Performance::Helpers::Current::Runner)
    end
  end

  describe "Comparator" do
    it "has the expected constants for the rake flow" do
      expect(Xmi::Performance::Comparator::DEFAULT_BASE).to eq("main")
      expect(Xmi::Performance::Comparator::DEFAULT_RUN_TIME).to be_a(Numeric)
      expect(Xmi::Performance::Comparator::DEFAULT_THRESHOLD).to be_a(Numeric)
    end
  end

  describe "Runner" do
    it "responds to run_benchmarks (the public entry point)" do
      expect(Xmi::Performance::Runner.instance_method(:run_benchmarks)).to be_a(UnboundMethod)
    end

    it "accepts run_time and warmup kwargs" do
      runner = Xmi::Performance::Runner.new(run_time: 1, warmup: 0)
      expect(runner).to be_a(Xmi::Performance::Runner)
    end
  end
end
# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
