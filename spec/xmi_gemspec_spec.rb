# frozen_string_literal: true

require "rubygems"

RSpec.describe "xmi.gemspec" do
  subject(:specification) do
    Gem::Specification.load(File.expand_path("../xmi.gemspec", __dir__))
  end

  it "depends on lutaml-model without a yanked-version upper cap" do
    dependency = specification.dependencies.find { |dep| dep.name == "lutaml-model" }
    expect(dependency.requirement).to eq(Gem::Requirement.new("~> 0.8.17"))
  end
end
