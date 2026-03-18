# frozen_string_literal: true

require "xmi"
require "canon"

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

# Read a fixture file and cache the content.
# This avoids repeated disk reads for the same fixture across tests.
#
# @param path [String] The relative path to the fixture file
# @return [String] The file content
def cached_fixture(path)
  @fixture_content_cache ||= {}
  @fixture_content_cache[path] ||= File.read(fixtures_path(path))
end
