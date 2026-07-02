# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Locks in the CURRENT concrete-class behavior of DefaultValue,
# UpperValue, and LowerValue — and the OwnedAttribute/OwnedEnd
# attributes that use them.
#
# TODO.refactor/15 (future) proposes making these polymorphic
# ValueSpecifications. When that lands, every assertion in this
# file flips. The diff makes the breaking change reviewable.
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "DefaultValue hierarchy current behavior" do
  describe Xmi::Uml::DefaultValue do
    it "is a direct Serializable (not yet a ValueSpecification)" do
      expect(described_class).to be < Lutaml::Model::Serializable
      expect(described_class).not_to be < Xmi::Uml::ValueSpecification
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

  describe "OwnedAttribute/OwnedEnd non-polymorphic upper/lower/default" do
    it "OwnedAttribute#upper_value is typed as UpperValue (concrete)" do
      attrs = Xmi::Uml::OwnedAttribute.attributes
      expect(attrs[:upper_value].type).to eq(Xmi::Uml::UpperValue)
      expect(attrs[:upper_value].options[:polymorphic]).to be_falsy
    end

    it "OwnedAttribute#lower_value is typed as LowerValue (concrete)" do
      attrs = Xmi::Uml::OwnedAttribute.attributes
      expect(attrs[:lower_value].type).to eq(Xmi::Uml::LowerValue)
      expect(attrs[:lower_value].options[:polymorphic]).to be_falsy
    end

    it "OwnedAttribute#default_value is typed as DefaultValue (concrete)" do
      attrs = Xmi::Uml::OwnedAttribute.attributes
      expect(attrs[:default_value].type).to eq(Xmi::Uml::DefaultValue)
      expect(attrs[:default_value].options[:polymorphic]).to be_falsy
    end

    it "OwnedEnd#upper_value is typed as UpperValue (concrete)" do
      attrs = Xmi::Uml::OwnedEnd.attributes
      expect(attrs[:upper_value].type).to eq(Xmi::Uml::UpperValue)
      expect(attrs[:upper_value].options[:polymorphic]).to be_falsy
    end

    it "OwnedEnd#lower_value is typed as LowerValue (concrete)" do
      attrs = Xmi::Uml::OwnedEnd.attributes
      expect(attrs[:lower_value].type).to eq(Xmi::Uml::LowerValue)
      expect(attrs[:lower_value].options[:polymorphic]).to be_falsy
    end

    it "OwnedEnd#default_value is typed as DefaultValue (concrete)" do
      attrs = Xmi::Uml::OwnedEnd.attributes
      expect(attrs[:default_value].type).to eq(Xmi::Uml::DefaultValue)
      expect(attrs[:default_value].options[:polymorphic]).to be_falsy
    end
  end
end
# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
