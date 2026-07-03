# frozen_string_literal: true

require "spec_helper"
require_relative "../../../lib/xmi"

# Concrete subclasses of ValueSpecification (default_value.rb and
# the upper_value/lower_value split). Literal subclasses are covered
# in literal_classes_spec.rb.
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "DefaultValue hierarchy" do
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

    it "round-trips value" do
      model = described_class.new(value: "anon", type: "uml:LiteralString", id: "X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.value).to eq("anon")
    end
  end

  describe Xmi::Uml::UpperValue do
    it "inherits from DefaultValue" do
      expect(described_class).to be < Xmi::Uml::DefaultValue
    end

    it "has root 'upperValue'" do
      expect(described_class.mappings_for(:xml).root_element).to eq("upperValue")
    end

    it "round-trips value" do
      model = described_class.new(value: "*", type: "uml:LiteralUnlimitedNatural", id: "X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.value).to eq("*")
    end
  end

  describe Xmi::Uml::LowerValue do
    it "inherits from DefaultValue" do
      expect(described_class).to be < Xmi::Uml::DefaultValue
    end

    it "has root 'lowerValue'" do
      expect(described_class.mappings_for(:xml).root_element).to eq("lowerValue")
    end

    it "round-trips value" do
      model = described_class.new(value: "0", type: "uml:LiteralInteger", id: "X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.value).to eq("0")
    end
  end
end
# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
