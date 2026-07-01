# frozen_string_literal: true

require "spec_helper"
require "xmi"

RSpec.describe Xmi::Uml::OwnedEnd do
  let(:namespace_xml) do
    %(xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:uml="http://www.omg.org/spec/UML/20131001")
  end

  let(:owned_end_xml) do
    %(<ownedEnd xmi:type="uml:Property" xmi:id="EAID_E2" association="EAID_A1" name="class1">\n      <type xmi:idref="EAID_C1"/>\n    </ownedEnd>)
  end

  let(:full_doc_xml) do
    <<~XML
      <xmi:XMI #{namespace_xml}>
        <xmi:Documentation exporter="EA"/>
        <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
          <packagedElement xmi:type="uml:Association" xmi:id="EAID_A1" name="assoc1">
            #{owned_end_xml}
          </packagedElement>
        </uml:Model>
      </xmi:XMI>
    XML
  end

  describe "parsing xmi:type discriminator" do
    subject(:owned_end) do
      Xmi::Sparx::Root.from_xml(full_doc_xml)
        .model.packaged_element.first.owned_end.first
    end

    it "captures xmi:type as the discriminator value" do
      expect(owned_end.type).to eq("uml:Property")
    end

    it "captures xmi:id" do
      expect(owned_end.id).to eq("EAID_E2")
    end

    it "captures association reference" do
      expect(owned_end.association).to eq("EAID_A1")
    end

    it "captures name" do
      expect(owned_end.name).to eq("class1")
    end

    it "captures the child <type> element as uml_type idref" do
      expect(owned_end.uml_type).to be_a(Xmi::Uml::Type)
      expect(owned_end.uml_type.idref).to eq("EAID_C1")
    end
  end

  describe "round-trip serialization" do
    it "preserves xmi:type discriminator on output" do
      reparsed = Xmi::Sparx::Root.from_xml(Xmi::Sparx::Root.from_xml(full_doc_xml).to_xml)
      owned_end = reparsed.model.packaged_element.first.owned_end.first
      expect(owned_end.type).to eq("uml:Property")
      expect(owned_end.id).to eq("EAID_E2")
    end
  end

  describe "attribute surface" do
    it "does not declare type_attr (duplicate removed)" do
      expect(described_class.attributes).not_to have_key(:type_attr)
    end

    it "declares type as XmiType (xmi:type discriminator)" do
      expect(described_class.attributes[:type].type).to eq(Xmi::Type::XmiType)
    end
  end

  describe "real fixture parity" do
    let(:doc) { Xmi::Sparx::Root.from_xml(cached_fixture("ea-xmi-2.5.1.xmi")) }

    let(:owned_ends) do
      result = []
      queue = [doc.model]
      while queue.any?
        node = queue.shift
        node.packaged_element.each do |pe|
          result.concat(pe.owned_end)
          queue << pe
        end
      end
      result
    end

    it "parses ea-xmi-2.5.1.xmi without losing xmi:type on ownedEnd elements" do
      expect(owned_ends).not_to be_empty
      owned_ends.each do |oe|
        expect(oe.type).to eq("uml:Property"), "expected uml:Property, got #{oe.type.inspect}"
      end
    end

    it "captures association reference on each ownedEnd" do
      owned_ends.each do |oe|
        expect(oe.association).to match(/\AEAID_[0-9A-Fa-f_]+\z/),
                                  "expected EAID_, got #{oe.association.inspect}"
      end
    end
  end

  describe "multiplicity child elements (upperValue / lowerValue)" do
    let(:owned_end_with_bounds_xml) do
      %(<ownedEnd xmi:type="uml:Property" xmi:id="EAID_E3" association="EAID_A2" name="src">\n        <type xmi:idref="EAID_C2"/>\n        <lowerValue xmi:type="uml:LiteralInteger" xmi:id="EAID_LI000001__src" value="0"/>\n        <upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="EAID_LI000002__src" value="1"/>\n      </ownedEnd>)
    end

    let(:full_doc) do
      <<~XML
        <xmi:XMI #{namespace_xml}>
          <xmi:Documentation exporter="EA"/>
          <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
            <packagedElement xmi:type="uml:Association" xmi:id="EAID_A2" name="assoc2">
              #{owned_end_with_bounds_xml}
            </packagedElement>
          </uml:Model>
        </xmi:XMI>
      XML
    end

    subject(:owned_end) do
      Xmi::Sparx::Root.from_xml(full_doc)
        .model.packaged_element.first.owned_end.first
    end

    it "parses <lowerValue> as a LowerValue model" do
      expect(owned_end.lower_value).to be_a(Xmi::Uml::LowerValue)
      expect(owned_end.lower_value.value).to eq("0")
    end

    it "parses <upperValue> as an UpperValue model" do
      expect(owned_end.upper_value).to be_a(Xmi::Uml::UpperValue)
      expect(owned_end.upper_value.value).to eq("1")
    end

    it "round-trips upperValue/lowerValue through serialize → parse" do
      reparsed = Xmi::Sparx::Root.from_xml(Xmi::Sparx::Root.from_xml(full_doc).to_xml)
        .model.packaged_element.first.owned_end.first
      expect(reparsed.lower_value.value).to eq("0")
      expect(reparsed.upper_value.value).to eq("1")
    end
  end

  describe "aggregation / visibility attributes" do
    let(:xml) do
      <<~XML
        <xmi:XMI #{namespace_xml}>
          <xmi:Documentation exporter="EA"/>
          <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
            <packagedElement xmi:type="uml:Association" xmi:id="EAID_A3">
              <ownedEnd xmi:type="uml:Property" xmi:id="EAID_E4" visibility="private" aggregation="composite"/>
            </packagedElement>
          </uml:Model>
        </xmi:XMI>
      XML
    end

    it "captures visibility" do
      owned_end = Xmi::Sparx::Root.from_xml(xml).model.packaged_element.first.owned_end.first
      expect(owned_end.visibility).to eq("private")
    end

    it "captures aggregation" do
      owned_end = Xmi::Sparx::Root.from_xml(xml).model.packaged_element.first.owned_end.first
      expect(owned_end.aggregation).to eq("composite")
    end
  end

  describe "schema migration (no backwards compat)" do
    it "does NOT declare Integer `lower` attribute (removed)" do
      expect(described_class.attributes).not_to have_key(:lower)
    end

    it "does NOT declare Integer `upper` attribute (removed)" do
      expect(described_class.attributes).not_to have_key(:upper)
    end

    it "declares lower_value as a LowerValue child model" do
      expect(described_class.attributes[:lower_value].type).to eq(Xmi::Uml::LowerValue)
    end

    it "declares upper_value as an UpperValue child model" do
      expect(described_class.attributes[:upper_value].type).to eq(Xmi::Uml::UpperValue)
    end
  end
end
