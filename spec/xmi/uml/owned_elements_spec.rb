# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Owned elements: OwnedComment and OwnedLiteral. Both inherit from
# Xmi::Uml::Base.
#
# rubocop:disable RSpec/DescribeClass
RSpec.describe "Owned elements" do
  describe Xmi::Uml::OwnedComment do
    it "inherits from Base" do
      expect(described_class).to be < Xmi::Uml::Base
    end

    it "declares body_element and body_attribute as :string" do
      attrs = described_class.attributes
      expect(attrs[:body_element].type).to eq(Lutaml::Model::Type::String)
      expect(attrs[:body_attribute].type).to eq(Lutaml::Model::Type::String)
    end

    it "declares annotated_element as AnnotatedElement" do
      expect(described_class.attributes[:annotated_element].type).to eq(Xmi::Uml::AnnotatedElement)
    end

    it "round-trips body_attribute form" do
      model = described_class.new(body_attribute: "comment text", id: "X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.body_attribute).to eq("comment text")
    end

    it "round-trips body_element form" do
      model = described_class.new(body_element: "element body", id: "X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.body_element).to eq("element body")
    end
  end

  describe Xmi::Uml::OwnedLiteral do
    it "inherits from Base" do
      expect(described_class).to be < Xmi::Uml::Base
    end

    it "declares name as :string" do
      expect(described_class.attributes[:name].type).to eq(Lutaml::Model::Type::String)
    end

    it "declares uml_type as Uml::Type" do
      expect(described_class.attributes[:uml_type].type).to eq(Xmi::Uml::Type)
    end

    it "round-trips name" do
      model = described_class.new(name: "RED", id: "X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.name).to eq("RED")
    end
  end
end

# rubocop:enable RSpec/DescribeClass
