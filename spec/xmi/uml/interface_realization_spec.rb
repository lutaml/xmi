# frozen_string_literal: true

require "spec_helper"
require "xmi"

RSpec.describe Xmi::Uml::InterfaceRealization do
  subject(:ir) do
    Xmi::Sparx::Root.from_xml(doc_xml)
      .model.packaged_element.first.interface_realization.first
  end

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

  describe "real fixture parity" do
    let(:doc) { Xmi::Sparx::Root.from_xml(cached_fixture("sparx-instance-specification.xmi")) }

    let(:impl) do
      doc.model.packaged_element.first.packaged_element
        .find { |pe| pe.name == "PersonImpl" }
    end

    it "parses the interfaceRealization child" do
      expect(impl.interface_realization.size).to eq(1)
    end

    it "captures the contract reference" do
      expect(impl.interface_realization.first.contract)
        .to eq("EAID_AA000000_0000_0000_0000_000000000010")
    end

    it "captures the client reference" do
      expect(impl.interface_realization.first.client)
        .to eq("EAID_AA000000_0000_0000_0000_000000000020")
    end

    it "captures the supplier reference" do
      expect(impl.interface_realization.first.supplier)
        .to eq("EAID_AA000000_0000_0000_0000_000000000010")
    end
  end

  describe "deployment context" do
    # Sparx EA's current XMI exporter collapses Class -> Interface
    # contracts into a generic `<packagedElement type="uml:Realization">`
    # rather than emitting the strict OMG `<interfaceRealization>` element.
    # The model in this gem exists for *emission* (the ea transformer
    # writes strict OMG shape) and for parsing strict OMG XMI.
    #
    # The synthetic fixture `sparx-instance-specification.xmi` exercises
    # the strict form. This spec locks in the deployment story: if Sparx
    # ever starts emitting the strict form, this assertion flips and
    # forces a follow-up conversation.

    it "is not present in current Sparx EA fixture output" do
      ea_fixture = cached_fixture("ea-xmi-2.5.1.xmi")
      expect(ea_fixture).not_to match(/<interfaceRealization/)
    end
  end
end
