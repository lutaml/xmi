# frozen_string_literal: true

require "spec_helper"
require "xmi"

# The namespace scope is declared once (Xmi::Namespace::SCOPE) and consumed
# by both sides of the Root → Mappings::BaseMapping seam. Drift between the
# two declarations is impossible; this pins it.
#
# rubocop:disable-next RSpec/DescribeClass
RSpec.describe "namespace scope" do
  it "exposes one canonical scope on Xmi::Namespace" do
    expect(Xmi::Namespace::SCOPE).to be_frozen
    expect(Xmi::Namespace::SCOPE.length).to eq(10)
  end

  it "Xmi::Root declares the canonical scope" do
    expect(Xmi::Root.mappings_for(:xml).namespace_scope)
      .to eq(Xmi::Namespace::SCOPE)
  end

  it "Mappings::BaseMapping declares the canonical scope" do
    expect(Xmi::Sparx::Root.mappings_for(:xml).namespace_scope)
      .to eq(Xmi::Namespace::SCOPE)
  end
end
