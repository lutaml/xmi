# frozen_string_literal: true

require "rubygems"

# rubocop:disable-next RSpec/DescribeClass
RSpec.describe "xmi.gemspec" do
  # Parsed from the file rather than Gem::Specification.load: inside
  # the dependent-gems harness the load context resolves dependencies
  # differently and the in-memory spec can come back dependency-less,
  # which said nothing about the gemspec's actual declaration.
  subject(:requirement) do
    source = File.read(File.expand_path("../xmi.gemspec", __dir__))
    dep = source[/add_dependency ["']lutaml-model["'],\s*(['"])(.+?)\1/, 2]
    raise "no lutaml-model dependency declared" unless dep

    Gem::Requirement.new(dep)
  end

  it "depends on lutaml-model without a yanked-version upper cap" do
    # Floor is functional: OwnedParameter's namespace-disjoint xmi:type
    # vs type slots need (URI, local name) attribute parsing (0.8.53).
    expect(requirement).to be_satisfied_by(Gem::Version.new("0.8.53"))
    expect(requirement.to_s).not_to include("<")
  end
end
