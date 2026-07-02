# frozen_string_literal: true

require "spec_helper"
require "xmi"

RSpec.describe Xmi::Uml::Slot do
  subject(:slot) do
    Xmi::Sparx::Root.from_xml(slot_xml)
      .model.packaged_element.first.slot.first
  end

  let(:namespace_xml) do
    %(xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:uml="http://www.omg.org/spec/UML/20131001")
  end

  let(:slot_xml) do
    <<~XML
      <xmi:XMI #{namespace_xml}>
        <xmi:Documentation exporter="EA"/>
        <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
          <packagedElement xmi:type="uml:InstanceSpecification" xmi:id="EAID_I1" name="instance1" classifier="EAID_C1">
            <slot xmi:type="uml:Slot" xmi:id="EAID_SL000001__I1" definingFeature="EAID_C1_attr">
              <value xmi:type="uml:OpaqueExpression" xmi:id="EAID_OE000001__I1" body="=Value One"/>
            </slot>
          </packagedElement>
        </uml:Model>
      </xmi:XMI>
    XML
  end

  it "is a Uml::Slot instance" do
    expect(slot).to be_a(described_class)
  end

  it "captures xmi:type discriminator" do
    expect(slot.type).to eq("uml:Slot")
  end

  it "captures xmi:id" do
    expect(slot.id).to eq("EAID_SL000001__I1")
  end

  it "captures definingFeature reference" do
    expect(slot.defining_feature).to eq("EAID_C1_attr")
  end

  it "parses <value> as an OpaqueExpression child model" do
    expect(slot.value.first).to be_a(Xmi::Uml::OpaqueExpression)
    expect(slot.value.first.body_attribute).to eq("=Value One")
  end

  it "round-trips through serialize → parse" do
    reparsed = Xmi::Sparx::Root.from_xml(Xmi::Sparx::Root.from_xml(slot_xml).to_xml)
      .model.packaged_element.first.slot.first
    expect(reparsed.defining_feature).to eq("EAID_C1_attr")
    expect(reparsed.value.first.body_attribute).to eq("=Value One")
  end

  describe "multi-value slots" do
    let(:multi_value_xml) do
      <<~XML
        <xmi:XMI #{namespace_xml}>
          <xmi:Documentation exporter="EA"/>
          <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
            <packagedElement xmi:type="uml:InstanceSpecification" xmi:id="EAID_I2" classifier="EAID_C1">
              <slot xmi:type="uml:Slot" xmi:id="EAID_SL2" definingFeature="EAID_X2">
                <value xmi:type="uml:OpaqueExpression" xmi:id="EAID_OE2" body="first"/>
                <value xmi:type="uml:OpaqueExpression" xmi:id="EAID_OE3" body="second"/>
              </slot>
            </packagedElement>
          </uml:Model>
        </xmi:XMI>
      XML
    end

    it "parses both <value> children in document order" do
      slot = Xmi::Sparx::Root.from_xml(multi_value_xml)
        .model.packaged_element.first.slot.first
      expect(slot.value.size).to eq(2)
      expect(slot.value.map(&:body_attribute)).to eq(["first", "second"])
    end

    it "round-trips both values" do
      reparsed = Xmi::Sparx::Root.from_xml(
        Xmi::Sparx::Root.from_xml(multi_value_xml).to_xml,
      ).model.packaged_element.first.slot.first
      expect(reparsed.value.size).to eq(2)
      expect(reparsed.value.map(&:body_attribute)).to eq(["first", "second"])
    end
  end

  describe "polymorphic value dispatch" do
    subject(:values) do
      Xmi::Sparx::Root.from_xml(mixed_values_xml)
        .model.packaged_element.first.slot.first.value
    end

    let(:mixed_values_xml) do
      <<~XML
        <xmi:XMI #{namespace_xml}>
          <xmi:Documentation exporter="EA"/>
          <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
            <packagedElement xmi:type="uml:InstanceSpecification" xmi:id="EAID_I3" classifier="EAID_C1">
              <slot xmi:type="uml:Slot" xmi:id="EAID_SL4" definingFeature="EAID_X4">
                <value xmi:type="uml:LiteralString" xmi:id="EAID_LS1" value="hello"/>
                <value xmi:type="uml:LiteralInteger" xmi:id="EAID_LI1" value="42"/>
                <value xmi:type="uml:LiteralBoolean" xmi:id="EAID_LB1" value="true"/>
                <value xmi:type="uml:LiteralUnlimitedNatural" xmi:id="EAID_LU1" value="*"/>
                <value xmi:type="uml:LiteralNull" xmi:id="EAID_LN1"/>
                <value xmi:type="uml:OpaqueExpression" xmi:id="EAID_OE4" body="opaque"/>
              </slot>
            </packagedElement>
          </uml:Model>
        </xmi:XMI>
      XML
    end

    it "dispatches each value to its xmi:type subclass" do
      expect(values.map(&:class)).to eq([
                                          Xmi::Uml::LiteralString,
                                          Xmi::Uml::LiteralInteger,
                                          Xmi::Uml::LiteralBoolean,
                                          Xmi::Uml::LiteralUnlimitedNatural,
                                          Xmi::Uml::LiteralNull,
                                          Xmi::Uml::OpaqueExpression,
                                        ])
    end

    it "parses LiteralString.value" do
      expect(values[0].value).to eq("hello")
    end

    it "parses LiteralInteger.value as integer" do
      expect(values[1].value).to eq(42)
    end

    it "parses LiteralBoolean.value as boolean" do
      expect(values[2].value).to be(true)
    end

    it "parses LiteralUnlimitedNatural.value as string" do
      expect(values[3].value).to eq("*")
    end

    it "preserves xmi:type discriminator on each" do
      expect(values.map(&:type)).to eq([
                                         "uml:LiteralString",
                                         "uml:LiteralInteger",
                                         "uml:LiteralBoolean",
                                         "uml:LiteralUnlimitedNatural",
                                         "uml:LiteralNull",
                                         "uml:OpaqueExpression",
                                       ])
    end

    it "round-trips mixed values" do
      reparsed = Xmi::Sparx::Root.from_xml(
        Xmi::Sparx::Root.from_xml(mixed_values_xml).to_xml,
      ).model.packaged_element.first.slot.first.value
      expect(reparsed.map(&:class)).to eq([
                                            Xmi::Uml::LiteralString,
                                            Xmi::Uml::LiteralInteger,
                                            Xmi::Uml::LiteralBoolean,
                                            Xmi::Uml::LiteralUnlimitedNatural,
                                            Xmi::Uml::LiteralNull,
                                            Xmi::Uml::OpaqueExpression,
                                          ])
    end

    it "all value subclasses inherit from ValueSpecification" do
      expect(values).to all(be_a(Xmi::Uml::ValueSpecification))
    end
  end

  describe "real fixture parity" do
    let(:doc) { Xmi::Sparx::Root.from_xml(cached_fixture("sparx-instance-specification.xmi")) }

    let(:alice) do
      doc.model.packaged_element.first.packaged_element
        .find { |pe| pe.name == "alice" }
    end

    it "parses both slots on the alice instance specification" do
      expect(alice.slot.size).to eq(2)
      expect(alice.slot.map(&:defining_feature)).to contain_exactly("EAID_AA000000_0000_0000_0000_000000000003", "EAID_AA000000_0000_0000_0000_000000000004")
    end

    it "parses the name slot's OpaqueExpression body" do
      name_slot = alice.slot.find { |s| s.defining_feature.end_with?("0000003") }
      expect(name_slot.value.first.body_attribute).to eq("Alice")
    end

    it "parses the age slot's OpaqueExpression body and language" do
      age_slot = alice.slot.find { |s| s.defining_feature.end_with?("0000004") }
      value = age_slot.value.first
      expect(value.body_attribute).to eq("42")
      expect(value.language_attribute).to eq("OCL")
    end
  end
end
