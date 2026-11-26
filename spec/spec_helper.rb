# frozen_string_literal: true

require_relative "../lib/xmi"
require_relative "fixtures"

# The adapter under test is explicit: the suite must not silently
# follow whatever the dev bundle happens to resolve. leptris is the
# default engine; override with XMI_XML_ADAPTER=nokogiri to run the
# suite against nokogiri for comparison. The performance-benchmark
# thresholds are environment-tuned (see spec/performance) — adapter
# parse-time deltas of ~10% through the model pipeline are known.
Lutaml::Model::Config.xml_adapter_type =
  (ENV["XMI_XML_ADAPTER"] || "leptris").to_sym

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def fixtures_path(path)
  File.join(File.expand_path("./fixtures", __dir__), path)
end

# Top-level constant so the cache persists across examples. The
# previous `@fixture_content_cache` ivar lived on `self`, which is
# the per-example RSpec instance — recreated empty on every call,
# defeating the cache. Intentionally mutable: entries are memoized
# on first access.
FIXTURE_CONTENT_CACHE = {} # rubocop:disable Style/MutableConstant

# Read a fixture file and cache the content.
# Avoids repeated disk reads for the same fixture across tests.
#
# @param path [String] The relative path to the fixture file
# @return [String] The file content
def cached_fixture(path)
  FIXTURE_CONTENT_CACHE[path] ||= File.read(fixtures_path(path))
end

require "canon"
Canon::Config.configure do |config|
  config.xml.match.profile = :spec_friendly
  config.xml.diff.use_color = true
end
