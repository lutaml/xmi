# frozen_string_literal: true

require "spec_helper"
require "xmi"

RSpec.describe Xmi::Uml::OpaqueExpression do
  let(:namespace_xml) do
    %(xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:uml="http://www.omg.org/spec/UML/20131001")
  end

  let(:doc_xml) do
    <<~XML
      <xmi:XMI #{namespace_xml}>
        <xmi:Documentation exporter="EA"/>
        <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
          <packagedElement xmi:type="uml:InstanceSpecification" xmi:id="EAID_I1" name="instance1">
            <slot xmi:type="uml:Slot" xmi:id="EAID_SL1" definingFeature="EAID_X1">
              <value xmi:type="uml:OpaqueExpression" xmi:id="EAID_OE1" body="42" language="OCL"/>
            </slot>
          </packagedElement>
        </uml:Model>
      </xmi:XMI>
    XML
  end

  subject(:expression) do
    Xmi::Sparx::Root.from_xml(doc_xml)
      .model.packaged_element.first.slot.first.value.first
  end

  it "is a Uml::OpaqueExpression instance" do
    expect(expression).to be_a(described_class)
  end

  it "captures xmi:type discriminator" do
    expect(expression.type).to eq("uml:OpaqueExpression")
  end

  it "captures body attribute" do
    expect(expression.body_attribute).to eq("42")
  end

  it "captures language attribute" do
    expect(expression.language).to eq("OCL")
  end

  it "round-trips through serialize → parse" do
    reparsed = Xmi::Sparx::Root.from_xml(Xmi::Sparx::Root.from_xml(doc_xml).to_xml)
      .model.packaged_element.first.slot.first.value.first
    expect(reparsed.body_attribute).to eq("42")
    expect(reparsed.language).to eq("OCL")
  end
end
