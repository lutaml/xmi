# frozen_string_literal: true

require "spec_helper"
require "xmi"

RSpec.describe Xmi::Uml::Slot do
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

  subject(:slot) do
    Xmi::Sparx::Root.from_xml(slot_xml)
      .model.packaged_element.first.slot.first
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
end
