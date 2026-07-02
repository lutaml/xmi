# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Files that intentionally define multiple constants under one file
# (constant-name-to-filename mapping doesn't apply).
SHARED_FILES = %w[default_value].freeze

# Smoke spec: every autoload entry under Xmi::Uml must resolve to
# a loadable file. Catches typos in the autoload path strings and
# constants that drift out of sync with lib/xmi/uml.rb.
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "Xmi::Uml autoload hygiene" do
  let(:described_constants) { Xmi::Uml.constants(false) }

  it "covers a non-trivial set of classes" do
    expect(described_constants.size).to be > 20
  end

  describe "each autoload entry" do
    it "loads every autoload entry without error" do
      described_constants.each do |const|
        expect { Xmi::Uml.const_get(const, false) }.not_to raise_error
      end
    end
  end

  describe "every lib/xmi/uml/*.rb file" do
    it "has a corresponding autoload entry for each file" do
      Dir[File.expand_path("../lib/xmi/uml/*.rb", __dir__)].each do |path|
        basename = File.basename(path, ".rb")
        if SHARED_FILES.include?(basename)
          # default_value.rb defines DefaultValue, UpperValue, LowerValue
          expect(Xmi::Uml.const_get(:DefaultValue, false)).to be_a(Class)
          expect(Xmi::Uml.const_get(:UpperValue, false)).to be_a(Class)
          expect(Xmi::Uml.const_get(:LowerValue, false)).to be_a(Class)
          next
        end

        classname = basename.gsub(/(?:^|_)(.)/) { Regexp.last_match(1).upcase }
        loaded = Xmi::Uml.const_get(classname, false)
        expect(loaded).to be_a(Class), "expected #{classname} to be a loadable class"
      end
    end
  end
end
# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
