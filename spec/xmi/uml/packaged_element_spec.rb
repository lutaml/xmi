# frozen_string_literal: true

require "spec_helper"
require "xmi"

RSpec.describe Xmi::Uml::PackagedElement do
  let(:namespace_xml) do
    %(xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:uml="http://www.omg.org/spec/UML/20131001")
  end

  def doc_with(attrs = "")
    <<~XML
      <xmi:XMI #{namespace_xml}>
        <xmi:Documentation exporter="EA"/>
        <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
          <packagedElement xmi:type="uml:Class" xmi:id="EAID_C1" name="Owner" #{attrs}/>
        </uml:Model>
      </xmi:XMI>
    XML
  end

  def packaged_element(doc)
    doc.model.packaged_element.first
  end

  describe "string attributes" do
    it "parses visibility" do
      pe = packaged_element(Xmi::Sparx::Root.from_xml(doc_with('visibility="public"')))
      expect(pe.visibility).to eq("public")
    end

    it "parses classifier" do
      pe = packaged_element(Xmi::Sparx::Root.from_xml(doc_with('classifier="EAID_X1"')))
      expect(pe.classifier).to eq("EAID_X1")
    end

    it "round-trips string attributes" do
      reparsed = Xmi::Sparx::Root.from_xml(
        Xmi::Sparx::Root.from_xml(doc_with('visibility="private" classifier="EAID_X1"')).to_xml,
      )
      pe = packaged_element(reparsed)
      expect(pe.visibility).to eq("private")
      expect(pe.classifier).to eq("EAID_X1")
    end

    it "defaults absent strings to nil" do
      pe = packaged_element(Xmi::Sparx::Root.from_xml(doc_with))
      expect(pe.visibility).to be_nil
      expect(pe.classifier).to be_nil
    end
  end

  describe "boolean flags" do
    it "parses isAbstract=true as true" do
      pe = packaged_element(Xmi::Sparx::Root.from_xml(doc_with('isAbstract="true"')))
      expect(pe.is_abstract).to be(true)
    end

    it "parses isLeaf=true as true" do
      pe = packaged_element(Xmi::Sparx::Root.from_xml(doc_with('isLeaf="true"')))
      expect(pe.is_leaf).to be(true)
    end

    it "parses isActive=true as true" do
      pe = packaged_element(Xmi::Sparx::Root.from_xml(doc_with('isActive="true"')))
      expect(pe.is_active).to be(true)
    end

    it "parses isAbstract=1 as true (EA shortcut)" do
      pe = packaged_element(Xmi::Sparx::Root.from_xml(doc_with('isAbstract="1"')))
      expect(pe.is_abstract).to be(true)
    end

    it "defaults absent flags to nil" do
      pe = packaged_element(Xmi::Sparx::Root.from_xml(doc_with))
      expect(pe.is_abstract).to be_nil
      expect(pe.is_leaf).to be_nil
      expect(pe.is_active).to be_nil
    end
  end

  describe "schema" do
    it "declares all is_* flags as :boolean" do
      attrs = described_class.attributes
      expect(attrs[:is_abstract].type).to eq(Lutaml::Model::Type::Boolean)
      expect(attrs[:is_leaf].type).to eq(Lutaml::Model::Type::Boolean)
      expect(attrs[:is_active].type).to eq(Lutaml::Model::Type::Boolean)
    end

    it "declares visibility/classifier as :string" do
      attrs = described_class.attributes
      expect(attrs[:visibility].type).to eq(Lutaml::Model::Type::String)
      expect(attrs[:classifier].type).to eq(Lutaml::Model::Type::String)
    end
  end
end
