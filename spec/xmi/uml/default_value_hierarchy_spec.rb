# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Locks in the CURRENT polymorphic behavior of DefaultValue,
# UpperValue, LowerValue — and the OwnedAttribute/OwnedEnd/
# OwnedParameter attributes that use them.
#
# This spec flipped from "concrete class" to "polymorphic
# ValueSpecification" when TODO 02 landed. The DefaultValue/
# UpperValue/LowerValue classes still exist as concrete subclasses
# for back-compat with code that constructs them directly
# (e.g. the lutaml/ea transformer).
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "DefaultValue hierarchy (polymorphic)" do
  describe Xmi::Uml::DefaultValue do
    it "inherits from ValueSpecification" do
      expect(described_class).to be < Xmi::Uml::ValueSpecification
    end

    it "declares value as :string" do
      expect(described_class.attributes[:value].type).to eq(Lutaml::Model::Type::String)
    end

    it "has root 'defaultValue'" do
      expect(described_class.mappings_for(:xml).root_element).to eq("defaultValue")
    end
  end

  describe Xmi::Uml::UpperValue do
    it "inherits from DefaultValue" do
      expect(described_class).to be < Xmi::Uml::DefaultValue
    end

    it "has root 'upperValue'" do
      expect(described_class.mappings_for(:xml).root_element).to eq("upperValue")
    end
  end

  describe Xmi::Uml::LowerValue do
    it "inherits from DefaultValue" do
      expect(described_class).to be < Xmi::Uml::DefaultValue
    end

    it "has root 'lowerValue'" do
      expect(described_class.mappings_for(:xml).root_element).to eq("lowerValue")
    end
  end

  describe "OwnedAttribute/OwnedEnd/OwnedParameter polymorphic upper/lower/default" do
    let(:expected_type) { Xmi::Uml::ValueSpecification }

    it "OwnedAttribute#upper_value is polymorphic ValueSpecification" do
      attrs = Xmi::Uml::OwnedAttribute.attributes
      expect(attrs[:upper_value].type).to eq(expected_type)
      expect(attrs[:upper_value].options[:polymorphic]).to be_truthy
    end

    it "OwnedAttribute#lower_value is polymorphic ValueSpecification" do
      attrs = Xmi::Uml::OwnedAttribute.attributes
      expect(attrs[:lower_value].type).to eq(expected_type)
      expect(attrs[:lower_value].options[:polymorphic]).to be_truthy
    end

    it "OwnedAttribute#default_value is polymorphic ValueSpecification" do
      attrs = Xmi::Uml::OwnedAttribute.attributes
      expect(attrs[:default_value].type).to eq(expected_type)
      expect(attrs[:default_value].options[:polymorphic]).to be_truthy
    end

    it "OwnedEnd#upper_value is polymorphic ValueSpecification" do
      attrs = Xmi::Uml::OwnedEnd.attributes
      expect(attrs[:upper_value].type).to eq(expected_type)
      expect(attrs[:upper_value].options[:polymorphic]).to be_truthy
    end

    it "OwnedEnd#lower_value is polymorphic ValueSpecification" do
      attrs = Xmi::Uml::OwnedEnd.attributes
      expect(attrs[:lower_value].type).to eq(expected_type)
      expect(attrs[:lower_value].options[:polymorphic]).to be_truthy
    end

    it "OwnedEnd#default_value is polymorphic ValueSpecification" do
      attrs = Xmi::Uml::OwnedEnd.attributes
      expect(attrs[:default_value].type).to eq(expected_type)
      expect(attrs[:default_value].options[:polymorphic]).to be_truthy
    end

    it "OwnedParameter#upper_value is polymorphic ValueSpecification" do
      attrs = Xmi::Uml::OwnedParameter.attributes
      expect(attrs[:upper_value].type).to eq(expected_type)
      expect(attrs[:upper_value].options[:polymorphic]).to be_truthy
    end

    it "OwnedParameter#lower_value is polymorphic ValueSpecification" do
      attrs = Xmi::Uml::OwnedParameter.attributes
      expect(attrs[:lower_value].type).to eq(expected_type)
      expect(attrs[:lower_value].options[:polymorphic]).to be_truthy
    end

    it "OwnedParameter#default_value is polymorphic ValueSpecification" do
      attrs = Xmi::Uml::OwnedParameter.attributes
      expect(attrs[:default_value].type).to eq(expected_type)
      expect(attrs[:default_value].options[:polymorphic]).to be_truthy
    end
  end

  describe "shared polymorphic dispatch map" do
    it "is defined as a constant on Xmi::Uml" do
      expect(Xmi::Uml::VALUE_SPECIFICATION_POLYMORPHIC_MAP).to be_a(Hash)
    end

    it "uses xmi:type as the discriminator" do
      expect(Xmi::Uml::VALUE_SPECIFICATION_POLYMORPHIC_MAP[:attribute]).to eq("xmi:type")
    end

    it "covers all concrete literal subclasses" do
      class_map = Xmi::Uml::VALUE_SPECIFICATION_POLYMORPHIC_MAP[:class_map]
      expect(class_map.keys).to contain_exactly(
        "uml:OpaqueExpression",
        "uml:LiteralString",
        "uml:LiteralInteger",
        "uml:LiteralBoolean",
        "uml:LiteralUnlimitedNatural",
        "uml:LiteralNull",
      )
    end
  end
end
# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
