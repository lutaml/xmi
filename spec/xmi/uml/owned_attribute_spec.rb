# frozen_string_literal: true

require "spec_helper"
require "xmi"

RSpec.describe Xmi::Uml::OwnedAttribute do
  let(:namespace_xml) do
    %(xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:uml="http://www.omg.org/spec/UML/20131001")
  end

  # attrs is the raw XML attribute string inserted into <ownedAttribute>.
  # Returns a full Sparx-shaped document parseable by Xmi::Sparx::Root.
  def doc_with(attrs = "")
    <<~XML
      <xmi:XMI #{namespace_xml}>
        <xmi:Documentation exporter="EA"/>
        <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
          <packagedElement xmi:type="uml:Class" xmi:id="EAID_C1" name="Owner">
            <ownedAttribute xmi:type="uml:Property" xmi:id="EAID_AT1" name="attr1" #{attrs}/>
          </packagedElement>
        </uml:Model>
      </xmi:XMI>
    XML
  end

  def owned_attribute(doc)
    doc.model.packaged_element.first.owned_attribute.first
  end

  describe "string attributes" do
    it "parses visibility" do
      oa = owned_attribute(Xmi::Sparx::Root.from_xml(doc_with('visibility="private"')))
      expect(oa.visibility).to eq("private")
    end

    it "parses aggregation" do
      oa = owned_attribute(Xmi::Sparx::Root.from_xml(doc_with('aggregation="composite"')))
      expect(oa.aggregation).to eq("composite")
    end

    it "parses default attribute" do
      oa = owned_attribute(Xmi::Sparx::Root.from_xml(doc_with('default="someDefault"')))
      expect(oa.default).to eq("someDefault")
    end

    it "round-trips string attributes" do
      reparsed = Xmi::Sparx::Root.from_xml(
        Xmi::Sparx::Root.from_xml(doc_with('visibility="private" aggregation="composite" default="d"')).to_xml,
      )
      oa = owned_attribute(reparsed)
      expect(oa.visibility).to eq("private")
      expect(oa.aggregation).to eq("composite")
      expect(oa.default).to eq("d")
    end

    it "defaults absent string attributes to nil" do
      oa = owned_attribute(Xmi::Sparx::Root.from_xml(doc_with))
      expect(oa.visibility).to be_nil
      expect(oa.aggregation).to be_nil
      expect(oa.default).to be_nil
    end
  end

  describe "boolean flags" do
    it "parses isDerived=true as true" do
      oa = owned_attribute(Xmi::Sparx::Root.from_xml(doc_with('isDerived="true"')))
      expect(oa.is_derived).to be(true)
    end

    it "parses isDerived=false as false" do
      oa = owned_attribute(Xmi::Sparx::Root.from_xml(doc_with('isDerived="false"')))
      expect(oa.is_derived).to be(false)
    end

    it "parses isID=1 as true (EA shortcut form)" do
      oa = owned_attribute(Xmi::Sparx::Root.from_xml(doc_with('isID="1"')))
      expect(oa.is_id).to be(true)
    end

    it "parses isOrdered=0 as false (EA shortcut form)" do
      oa = owned_attribute(Xmi::Sparx::Root.from_xml(doc_with('isOrdered="0"')))
      expect(oa.is_ordered).to be(false)
    end

    it "parses isUnique=true as true" do
      oa = owned_attribute(Xmi::Sparx::Root.from_xml(doc_with('isUnique="true"')))
      expect(oa.is_unique).to be(true)
    end

    it "parses isReadOnly=true as true" do
      oa = owned_attribute(Xmi::Sparx::Root.from_xml(doc_with('isReadOnly="true"')))
      expect(oa.is_read_only).to be(true)
    end

    it "defaults absent flags to nil" do
      oa = owned_attribute(Xmi::Sparx::Root.from_xml(doc_with))
      expect(oa.is_derived).to be_nil
      expect(oa.is_id).to be_nil
      expect(oa.is_ordered).to be_nil
      expect(oa.is_unique).to be_nil
      expect(oa.is_read_only).to be_nil
    end
  end

  describe "defaultValue child element" do
    let(:doc) do
      <<~XML
        <xmi:XMI #{namespace_xml}>
          <xmi:Documentation exporter="EA"/>
          <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
            <packagedElement xmi:type="uml:Class" xmi:id="EAID_C1" name="Owner">
              <ownedAttribute xmi:type="uml:Property" xmi:id="EAID_AT2" name="attr2">
                <defaultValue xmi:type="uml:LiteralString" xmi:id="EAID_DV1" value="default-text"/>
              </ownedAttribute>
            </packagedElement>
          </uml:Model>
        </xmi:XMI>
      XML
    end

    it "parses <defaultValue> as a LiteralString (polymorphic dispatch)" do
      oa = owned_attribute(Xmi::Sparx::Root.from_xml(doc))
      expect(oa.default_value).to be_a(Xmi::Uml::LiteralString)
      expect(oa.default_value).to be_a(Xmi::Uml::ValueSpecification)
      expect(oa.default_value.value).to eq("default-text")
      expect(oa.default_value.type).to eq("uml:LiteralString")
    end

    it "round-trips defaultValue through serialize → parse" do
      reparsed = Xmi::Sparx::Root.from_xml(Xmi::Sparx::Root.from_xml(doc).to_xml)
      oa = owned_attribute(reparsed)
      expect(oa.default_value.value).to eq("default-text")
      expect(oa.default_value.type).to eq("uml:LiteralString")
    end
  end

  describe "schema" do
    it "declares all is_* flags as :boolean" do
      attrs = described_class.attributes
      expect(attrs[:is_derived].type).to eq(Lutaml::Model::Type::Boolean)
      expect(attrs[:is_id].type).to eq(Lutaml::Model::Type::Boolean)
      expect(attrs[:is_ordered].type).to eq(Lutaml::Model::Type::Boolean)
      expect(attrs[:is_unique].type).to eq(Lutaml::Model::Type::Boolean)
      expect(attrs[:is_read_only].type).to eq(Lutaml::Model::Type::Boolean)
    end

    it "declares visibility/aggregation/default as :string" do
      attrs = described_class.attributes
      expect(attrs[:visibility].type).to eq(Lutaml::Model::Type::String)
      expect(attrs[:aggregation].type).to eq(Lutaml::Model::Type::String)
      expect(attrs[:default].type).to eq(Lutaml::Model::Type::String)
    end
  end

  describe "element order (EA parity)" do
    # Real Sparx output nests children of ownedAttribute as
    # <type>, then <lowerValue>, then <upperValue> — see full-242.xmi.
    # Pinned because the value trio is inherited from ValueSpecs, and
    # inherited element mappings serialize before subclass mappings.
    it "serializes type before the values, lowerValue before upperValue" do
      xml = doc_with(<<~CHILDREN.chomp)
        >
          <type xmi:idref="EAID_T1"/>
          <upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="EAID_U1" value="*"/>
          <lowerValue xmi:type="uml:LiteralInteger" xmi:id="EAID_L1" value="0"/>
        </ownedAttribute
      CHILDREN
      output = owned_attribute(Xmi::Sparx::Root.from_xml(xml)).to_xml
      expect(output.index("<type")).to be < output.index("<lowerValue")
      expect(output.index("<lowerValue")).to be < output.index("<upperValue")
    end
  end
end
