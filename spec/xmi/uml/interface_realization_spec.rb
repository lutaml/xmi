# frozen_string_literal: true

require "spec_helper"
require "xmi"

RSpec.describe Xmi::Uml::InterfaceRealization do
  let(:namespace_xml) do
    %(xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:uml="http://www.omg.org/spec/UML/20131001")
  end

  let(:doc_xml) do
    <<~XML
      <xmi:XMI #{namespace_xml}>
        <xmi:Documentation exporter="EA"/>
        <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
          <packagedElement xmi:type="uml:Class" xmi:id="EAID_C1" name="Impl">
            <interfaceRealization xmi:type="uml:InterfaceRealization" xmi:id="EAID_IR1" client="EAID_C1" supplier="EAID_I1" contract="EAID_I1"/>
          </packagedElement>
        </uml:Model>
      </xmi:XMI>
    XML
  end

  subject(:ir) do
    Xmi::Sparx::Root.from_xml(doc_xml)
      .model.packaged_element.first.interface_realization.first
  end

  it "is a Uml::InterfaceRealization instance" do
    expect(ir).to be_a(described_class)
  end

  it "captures xmi:type discriminator" do
    expect(ir.type).to eq("uml:InterfaceRealization")
  end

  it "captures client reference" do
    expect(ir.client).to eq("EAID_C1")
  end

  it "captures supplier reference" do
    expect(ir.supplier).to eq("EAID_I1")
  end

  it "captures contract reference" do
    expect(ir.contract).to eq("EAID_I1")
  end

  it "round-trips through serialize → parse" do
    reparsed = Xmi::Sparx::Root.from_xml(Xmi::Sparx::Root.from_xml(doc_xml).to_xml)
      .model.packaged_element.first.interface_realization.first
    expect(reparsed.client).to eq("EAID_C1")
    expect(reparsed.contract).to eq("EAID_I1")
  end
end
