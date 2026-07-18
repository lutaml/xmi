# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Top-level UmlModel — the root <uml:Model> element. Carries
# packagedElement, packageImport, profileApplication, and Diagram.
RSpec.describe Xmi::Uml::UmlModel do
  it "inherits from Base" do
    expect(described_class).to be < Xmi::Uml::Base
  end

  it "declares name as :string" do
    expect(described_class.attributes[:name].type).to eq(Lutaml::Model::Type::String)
  end

  it "declares packaged_element as polymorphic PackagedElement collection" do
    attr = described_class.attributes[:packaged_element]
    expect(attr.type).to eq(Xmi::Uml::PackagedElement)
    expect(attr.collection?).to be(true)
    expect(attr.options[:polymorphic]).to be_truthy
  end

  it "declares profile_application as ProfileApplication collection" do
    attr = described_class.attributes[:profile_application]
    expect(attr.type).to eq(Xmi::Uml::ProfileApplication)
    expect(attr.collection?).to be(true)
  end

  it "declares package_import as PackageImport collection" do
    attr = described_class.attributes[:package_import]
    expect(attr.type).to eq(Xmi::Uml::PackageImport)
    expect(attr.collection?).to be(true)
  end

  it "declares diagram as Diagram single" do
    expect(described_class.attributes[:diagram].type).to eq(Xmi::Uml::Diagram)
  end

  it "round-trips name" do
    model = described_class.new(name: "EA_Model", id: "M1")
    reparsed = described_class.from_xml(model.to_xml)
    expect(reparsed.name).to eq("EA_Model")
  end
end
