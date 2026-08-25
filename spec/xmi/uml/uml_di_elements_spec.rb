# frozen_string_literal: true

require "spec_helper"
require "xmi"

# UMLDI elements: Bounds, Waypoint, Diagram, OwnedElement. All
# inherit from Xmi::UmlDi::Base (UMLDI namespace, not UML).
#
# rubocop:disable RSpec/DescribeClass
RSpec.describe "UMLDI elements" do
  describe Xmi::UmlDi::Base do
    it "is a Lutaml::Model::Serializable" do
      expect(described_class).to be < Lutaml::Model::Serializable
    end

    it "declares type as XmiType" do
      expect(described_class.attributes[:type].type).to eq(Xmi::Type::XmiType)
    end

    it "declares id as XmiId" do
      expect(described_class.attributes[:id].type).to eq(Xmi::Type::XmiId)
    end
  end

  describe Xmi::Uml::Bounds do
    it "inherits from UmlDi::Base" do
      expect(described_class).to be < Xmi::UmlDi::Base
    end

    it "declares x, y, height, width as :integer" do
      attrs = described_class.attributes
      expect(attrs[:x].type).to eq(Lutaml::Model::Type::Integer)
      expect(attrs[:y].type).to eq(Lutaml::Model::Type::Integer)
      expect(attrs[:height].type).to eq(Lutaml::Model::Type::Integer)
      expect(attrs[:width].type).to eq(Lutaml::Model::Type::Integer)
    end

    it "round-trips bounds values" do
      model = described_class.new(x: 10, y: 20, height: 100, width: 200)
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.x).to eq(10)
      expect(reparsed.y).to eq(20)
      expect(reparsed.height).to eq(100)
      expect(reparsed.width).to eq(200)
    end
  end

  describe Xmi::Uml::Waypoint do
    it "inherits from UmlDi::Base" do
      expect(described_class).to be < Xmi::UmlDi::Base
    end

    it "declares x and y as :integer" do
      attrs = described_class.attributes
      expect(attrs[:x].type).to eq(Lutaml::Model::Type::Integer)
      expect(attrs[:y].type).to eq(Lutaml::Model::Type::Integer)
    end

    it "round-trips x and y" do
      model = described_class.new(x: 5, y: 15)
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.x).to eq(5)
      expect(reparsed.y).to eq(15)
    end
  end

  describe Xmi::Uml::Diagram do
    it "inherits from UmlDi::Base" do
      expect(described_class).to be < Xmi::UmlDi::Base
    end

    it "declares is_frame as :boolean" do
      expect(described_class.attributes[:is_frame].type).to eq(Lutaml::Model::Type::Boolean)
    end

    it "declares model_element as :string" do
      expect(described_class.attributes[:model_element].type).to eq(Lutaml::Model::Type::String)
    end

    it "declares owned_element as OwnedElement collection" do
      attr = described_class.attributes[:owned_element]
      expect(attr.type).to eq(Xmi::Uml::OwnedElement)
      expect(attr.collection?).to be(true)
    end
  end

  describe Xmi::Uml::OwnedElement do
    it "inherits from UmlDi::Base" do
      expect(described_class).to be < Xmi::UmlDi::Base
    end

    it "declares text and model_element as :string" do
      attrs = described_class.attributes
      expect(attrs[:text].type).to eq(Lutaml::Model::Type::String)
      expect(attrs[:model_element].type).to eq(Lutaml::Model::Type::String)
    end

    it "declares bounds as Bounds collection" do
      attr = described_class.attributes[:bounds]
      expect(attr.type).to eq(Xmi::Uml::Bounds)
      expect(attr.collection?).to be(true)
    end

    it "declares waypoint as Waypoint single" do
      attr = described_class.attributes[:waypoint]
      expect(attr.type).to eq(Xmi::Uml::Waypoint)
    end
  end
end

# rubocop:enable RSpec/DescribeClass
