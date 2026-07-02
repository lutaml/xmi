# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Standalone specs for the literal ValueSpecification subclasses.
# These complement the integration coverage in slot_spec.rb's
# "polymorphic value dispatch" block by exercising each class on
# its own — direct construction, direct round-trip, defaults.
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "ValueSpecification subclass literals" do
  describe Xmi::Uml::LiteralString do
    it "inherits from ValueSpecification" do
      expect(described_class).to be < Xmi::Uml::ValueSpecification
    end

    it "constructs with value" do
      model = described_class.new(value: "hello")
      expect(model.value).to eq("hello")
    end

    it "round-trips value through xml" do
      model = described_class.new(value: "hello", type: "uml:LiteralString",
                                  id: "X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.value).to eq("hello")
      expect(reparsed.type).to eq("uml:LiteralString")
    end
  end

  describe Xmi::Uml::LiteralInteger do
    it "inherits from ValueSpecification" do
      expect(described_class).to be < Xmi::Uml::ValueSpecification
    end

    it "constructs with integer value" do
      model = described_class.new(value: 42)
      expect(model.value).to eq(42)
    end

    it "round-trips integer value through xml" do
      model = described_class.new(value: 7, type: "uml:LiteralInteger",
                                  id: "X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.value).to eq(7)
    end
  end

  describe Xmi::Uml::LiteralBoolean do
    it "inherits from ValueSpecification" do
      expect(described_class).to be < Xmi::Uml::ValueSpecification
    end

    it "constructs with boolean value" do
      model = described_class.new(value: true)
      expect(model.value).to be(true)
    end

    it "round-trips boolean value through xml" do
      model = described_class.new(value: false, type: "uml:LiteralBoolean",
                                  id: "X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.value).to be(false)
    end
  end

  describe Xmi::Uml::LiteralUnlimitedNatural do
    it "inherits from ValueSpecification" do
      expect(described_class).to be < Xmi::Uml::ValueSpecification
    end

    it "constructs with '*' as string" do
      model = described_class.new(value: "*")
      expect(model.value).to eq("*")
    end

    it "round-trips '*' as string" do
      model = described_class.new(value: "*",
                                  type: "uml:LiteralUnlimitedNatural", id: "X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.value).to eq("*")
    end
  end

  describe Xmi::Uml::LiteralNull do
    it "inherits from ValueSpecification" do
      expect(described_class).to be < Xmi::Uml::ValueSpecification
    end

    it "has no value attribute (UML 2.5 §9.8.2.4)" do
      expect(described_class.attributes).not_to have_key(:value)
    end

    it "round-trips with only type and id" do
      model = described_class.new(type: "uml:LiteralNull", id: "X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.type).to eq("uml:LiteralNull")
      expect(reparsed.id).to eq("X1")
    end
  end

  describe Xmi::Uml::OpaqueExpression do
    it "inherits from ValueSpecification" do
      expect(described_class).to be < Xmi::Uml::ValueSpecification
    end

    it "constructs with body and language collections" do
      model = described_class.new(body: ["a", "b"], language: ["OCL", "Alf"])
      expect(model.body).to eq(["a", "b"])
      expect(model.language).to eq(["OCL", "Alf"])
    end

    it "round-trips multi-body through xml" do
      model = described_class.new(
        body: ["first", "second"],
        language: ["OCL", "Alf"],
        type: "uml:OpaqueExpression",
        id: "X1",
      )
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.body).to eq(["first", "second"])
      expect(reparsed.language).to eq(["OCL", "Alf"])
    end

    it "round-trips body_attribute form" do
      model = described_class.new(
        body_attribute: "shortcut",
        language_attribute: "OCL",
        type: "uml:OpaqueExpression",
      )
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.body_attribute).to eq("shortcut")
      expect(reparsed.language_attribute).to eq("OCL")
    end
  end

  describe Xmi::Uml::ValueSpecification do
    it "is the abstract base for all literal subclasses" do
      subclasses = [
        Xmi::Uml::OpaqueExpression,
        Xmi::Uml::LiteralString,
        Xmi::Uml::LiteralInteger,
        Xmi::Uml::LiteralBoolean,
        Xmi::Uml::LiteralUnlimitedNatural,
        Xmi::Uml::LiteralNull,
      ]
      expect(subclasses).to all(be < described_class)
    end

    it "declares type with polymorphic_class marker" do
      type_attr = described_class.attributes[:type]
      expect(type_attr.options[:polymorphic_class]).to be_truthy
    end
  end
end
# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
