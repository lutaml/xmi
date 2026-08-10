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

  describe "nestedClassifier" do
    it "round-trips nested classifiers (Sparx nesting for class-owned classes)" do
      xml = <<~XML
        <packagedElement #{namespace_xml} xmi:type="uml:Class" xmi:id="EAID_OUTER" name="Outer">
          <nestedClassifier xmi:type="uml:Class" xmi:id="EAID_INNER" name="Inner"/>
        </packagedElement>
      XML
      element = described_class.from_xml(xml)
      expect(element.nested_classifier.map(&:name)).to eq(["Inner"])
      expect(element.packaged_element).to be_empty
      expect(element.to_xml).to match(/<nestedClassifier[^>]*name="Inner"/)
      expect(element.to_xml).to include(%(xmi:id="EAID_INNER"))
    end
  end

  describe "Sparx sibling order" do
    # Inputs list upperValue FIRST so a pass proves the mapping order —
    # not the input order — controls serialization.
    it "serializes lowerValue before upperValue on owned attributes" do
      xml = <<~XML
        <packagedElement #{namespace_xml} xmi:type="uml:Class" xmi:id="EAID_C" name="C">
          <ownedAttribute xmi:type="uml:Property" xmi:id="EAID_A" name="a">
            <upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="EAID_U" value="1"/>
            <lowerValue xmi:type="uml:LiteralInteger" xmi:id="EAID_L" value="1"/>
          </ownedAttribute>
        </packagedElement>
      XML
      output = described_class.from_xml(xml).to_xml
      expect(output.index("<lowerValue")).to be < output.index("<upperValue")
    end

    it "serializes lowerValue before upperValue on owned ends" do
      xml = <<~XML
        <packagedElement #{namespace_xml} xmi:type="uml:Association" xmi:id="EAID_AS" name="A">
          <ownedEnd xmi:type="uml:Property" xmi:id="EAID_E" name="e">
            <upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="EAID_U" value="*"/>
            <lowerValue xmi:type="uml:LiteralInteger" xmi:id="EAID_L" value="0"/>
          </ownedEnd>
        </packagedElement>
      XML
      output = described_class.from_xml(xml).to_xml
      expect(output.index("<lowerValue")).to be < output.index("<upperValue")
    end
  end
end
