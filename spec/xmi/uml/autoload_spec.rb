# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Skip files that don't follow the filename→CamelCase convention.
NON_CLASS_FILES = %w[base profile_attributes].freeze

# Smoke spec: every autoload entry under Xmi::Uml must resolve to
# a loadable file. Catches typos in the autoload path strings and
# constants that drift out of sync with lib/xmi/uml.rb.
#
# rubocop:disable-next RSpec/DescribeClass
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
    it "has a corresponding autoload entry matching its filename" do
      Dir[File.expand_path("../lib/xmi/uml/*.rb", __dir__)].each do |path|
        basename = File.basename(path, ".rb")
        # Skip Base: it is the abstract parent and not file-named (would be `base.rb` → `Base`).
        # Skip profile_attributes: it's a Ruby module, not a class — autoload still works.
        next if NON_CLASS_FILES.include?(basename)

        classname = basename.gsub(/(?:^|_)(.)/) { Regexp.last_match(1).upcase }
        loaded = Xmi::Uml.const_get(classname, false)
        expect(loaded).to be_a(Class),
                          "expected #{classname} to be a loadable class"
      end
    end
  end
end
