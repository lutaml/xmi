# frozen_string_literal: true

require "rubygems"

# rubocop:disable-next RSpec/DescribeClass
RSpec.describe "xmi.gemspec" do
  subject(:specification) do
    Gem::Specification.load(File.expand_path("../xmi.gemspec", __dir__))
  end

  it "depends on lutaml-model without a yanked-version upper cap" do
    dependency = specification.dependencies.find { |dep| dep.name == "lutaml-model" }
    # Floor is functional: OwnedParameter's namespace-disjoint xmi:type
    # vs type slots need (URI, local name) attribute parsing (0.8.53).
    expect(dependency.requirement).to eq(Gem::Requirement.new("~> 0.8.53"))
  end
end
