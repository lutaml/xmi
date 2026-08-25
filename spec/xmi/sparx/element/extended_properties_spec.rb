# frozen_string_literal: true

require "spec_helper"
require "xmi"

# ExtendedProperties: the <extendedProperties> child of EA <element>
# entries inside connector extension blocks. EA writes attribute names
# verbatim here — `package_name` and `associationclass` are literal
# spellings, not camelCase variants.
RSpec.describe Xmi::Sparx::Element::ExtendedProperties do
  describe "schema" do
    it "declares tagged and package_name as :string" do
      attrs = described_class.attributes
      expect(attrs[:tagged].type).to eq(Lutaml::Model::Type::String)
      expect(attrs[:package_name].type).to eq(Lutaml::Model::Type::String)
    end

    it "declares virtual_inheritance as :integer" do
      expect(described_class.attributes[:virtual_inheritance].type)
        .to eq(Lutaml::Model::Type::Integer)
    end

    it "declares associationclass as :string" do
      expect(described_class.attributes[:associationclass].type)
        .to eq(Lutaml::Model::Type::String)
    end
  end

  describe "associationclass" do
    let(:ea_id) { "EAID_18E08BBD_DC0E_409a_AA6E_49C20958C49B" }

    it "round-trips the Sparx EAID reference with sibling attributes" do
      model = described_class.new(
        associationclass: ea_id,
        virtual_inheritance: 0,
        package_name: "Model",
        tagged: "tagged",
      )
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.associationclass).to eq(ea_id)
      expect(reparsed.virtual_inheritance).to eq(0)
      expect(reparsed.package_name).to eq("Model")
      expect(reparsed.tagged).to eq("tagged")
    end

    it "serializes the attribute in EA's literal spelling" do
      xml = described_class.new(associationclass: ea_id).to_xml
      expect(xml).to include(%(associationclass="#{ea_id}"))
      expect(xml).not_to include("associationClass=")
    end
  end
end
