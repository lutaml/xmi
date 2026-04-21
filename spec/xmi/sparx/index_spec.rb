# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::Index do
  let(:xml_content) { cached_fixture("ea-xmi-2.5.1.xmi") }
  let(:root) { Xmi::Sparx::Root.parse_xml(xml_content) }
  let(:index) { root.index }

  it "builds id_name_map" do
    expect(index.id_name_map).to be_a(Hash)
    expect(index.id_name_map).not_to be_empty
  end

  it "supports lookup_name" do
    some_id = index.id_name_map.keys.first
    expect(index.lookup_name(some_id)).to eq(index.id_name_map[some_id])
  end

  it "returns nil for unknown id" do
    expect(index.lookup_name("nonexistent")).to be_nil
  end

  it "builds packaged_elements" do
    expect(index.packaged_elements).to be_an(Array)
    expect(index.packaged_elements).not_to be_empty
  end

  it "builds elements_by_idref" do
    expect(index.elements_by_idref).to be_a(Hash)
  end

  it "freezes the index" do
    expect(index).to be_frozen
  end

  describe "#find_packaged_element" do
    it "finds element by id" do
      some_id = index.packaged_by_id.keys.first
      expect(index.find_packaged_element(some_id)).not_to be_nil
    end

    it "returns nil for unknown id" do
      expect(index.find_packaged_element("nonexistent")).to be_nil
    end
  end

  describe "#find_packaged_by_name_and_types" do
    it "returns nil for unknown name" do
      result = index.find_packaged_by_name_and_types("NonExistent",
                                                     ["uml:Class"])
      expect(result).to be_nil
    end
  end

  describe "#find_element" do
    it "returns nil for unknown idref" do
      expect(index.find_element("nonexistent")).to be_nil
    end
  end

  describe "#find_connector" do
    it "returns nil for unknown idref" do
      expect(index.find_connector("nonexistent")).to be_nil
    end
  end

  describe "#find_attribute" do
    it "returns nil for unknown idref" do
      expect(index.find_attribute("nonexistent")).to be_nil
    end
  end

  describe "#find_owned_attrs_by_type" do
    it "returns empty array for unknown type" do
      expect(index.find_owned_attrs_by_type("nonexistent")).to eq([])
    end
  end

  describe "#packaged_elements_of_type" do
    it "returns empty array for unknown type" do
      expect(index.packaged_elements_of_type("uml:NonExistent")).to eq([])
    end
  end
end
