# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Specification + Precondition. Specification captures text content
# (constraint expressions); Precondition wraps Specification.
#
# rubocop:disable RSpec/DescribeClass
RSpec.describe "Specification and Precondition" do
  describe Xmi::Uml::Specification do
    it "inherits from Base" do
      expect(described_class).to be < Xmi::Uml::Base
    end

    it "declares language as :string" do
      expect(described_class.attributes[:language].type).to eq(Lutaml::Model::Type::String)
    end

    it "declares content as :string (text content mapping)" do
      expect(described_class.attributes[:content].type).to eq(Lutaml::Model::Type::String)
    end

    it "round-trips language attribute and text content" do
      model = described_class.new(language: "OCL", content: "context Person inv: self.age >= 0", id: "X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.language).to eq("OCL")
      expect(reparsed.content).to include("context Person inv")
    end
  end

  describe Xmi::Uml::Precondition do
    it "inherits from Base" do
      expect(described_class).to be < Xmi::Uml::Base
    end

    it "declares name as :string" do
      expect(described_class.attributes[:name].type).to eq(Lutaml::Model::Type::String)
    end

    it "declares specification as Specification" do
      expect(described_class.attributes[:specification].type).to eq(Xmi::Uml::Specification)
    end

    it "round-trips name and nested specification" do
      inner = Xmi::Uml::Specification.new(language: "OCL", content: "x > 0", id: "S1")
      model = described_class.new(name: "positive", specification: inner, id: "P1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.name).to eq("positive")
      expect(reparsed.specification).to be_a(Xmi::Uml::Specification)
      expect(reparsed.specification.content).to eq("x > 0")
    end
  end
end

# rubocop:enable RSpec/DescribeClass
