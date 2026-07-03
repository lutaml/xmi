# frozen_string_literal: true

require "spec_helper"
require "xmi"

RSpec.describe Xmi::Uml::OpaqueExpression do
  subject(:expression) do
    Xmi::Sparx::Root.from_xml(doc_xml)
      .model.packaged_element.first.slot.first.value.first
  end

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
    expect(expression.language_attribute).to eq("OCL")
  end

  it "round-trips through serialize → parse" do
    reparsed = Xmi::Sparx::Root.from_xml(Xmi::Sparx::Root.from_xml(doc_xml).to_xml)
      .model.packaged_element.first.slot.first.value.first
    expect(reparsed.body_attribute).to eq("42")
    expect(reparsed.language_attribute).to eq("OCL")
  end

  describe "<body> / <language> as child elements" do
    subject(:element_expression) do
      Xmi::Sparx::Root.from_xml(element_body_xml)
        .model.packaged_element.first.slot.first.value.first
    end

    let(:element_body_xml) do
      <<~XML
        <xmi:XMI #{namespace_xml}>
          <xmi:Documentation exporter="EA"/>
          <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
            <packagedElement xmi:type="uml:InstanceSpecification" xmi:id="EAID_I1">
              <slot xmi:type="uml:Slot" xmi:id="EAID_SL2" definingFeature="EAID_X2">
                <value xmi:type="uml:OpaqueExpression" xmi:id="EAID_OE2">
                  <body>body-as-element</body>
                  <language>OCL</language>
                </value>
              </slot>
            </packagedElement>
          </uml:Model>
        </xmi:XMI>
      XML
    end

    it "parses <body> element into the body collection" do
      expect(element_expression.body).to eq(["body-as-element"])
      expect(element_expression.language).to eq(["OCL"])
    end

    it "leaves body_attribute nil when only the element form is present" do
      expect(element_expression.body_attribute).to be_nil
    end

    it "round-trips element-bodied expression" do
      reparsed = Xmi::Sparx::Root.from_xml(
        Xmi::Sparx::Root.from_xml(element_body_xml).to_xml,
      ).model.packaged_element.first.slot.first.value.first
      expect(reparsed.body).to eq(["body-as-element"])
      expect(reparsed.language).to eq(["OCL"])
    end
  end

  describe "multi-language body/language pairs" do
    let(:multi_lang_xml) do
      <<~XML
        <xmi:XMI #{namespace_xml}>
          <xmi:Documentation exporter="EA"/>
          <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
            <packagedElement xmi:type="uml:InstanceSpecification" xmi:id="EAID_I2">
              <slot xmi:type="uml:Slot" xmi:id="EAID_SL3" definingFeature="EAID_X3">
                <value xmi:type="uml:OpaqueExpression" xmi:id="EAID_OE3">
                  <body>first</body>
                  <language>OCL</language>
                  <body>second</body>
                  <language>Alf</language>
                </value>
              </slot>
            </packagedElement>
          </uml:Model>
        </xmi:XMI>
      XML
    end

    it "preserves body/language order as parallel arrays" do
      expr = Xmi::Sparx::Root.from_xml(multi_lang_xml)
        .model.packaged_element.first.slot.first.value.first
      expect(expr.body).to eq(["first", "second"])
      expect(expr.language).to eq(["OCL", "Alf"])
    end

    it "round-trips both pairs" do
      reparsed = Xmi::Sparx::Root.from_xml(
        Xmi::Sparx::Root.from_xml(multi_lang_xml).to_xml,
      ).model.packaged_element.first.slot.first.value.first
      expect(reparsed.body).to eq(["first", "second"])
      expect(reparsed.language).to eq(["OCL", "Alf"])
    end
  end

  describe "real fixture parity" do
    let(:doc) { Xmi::Sparx::Root.from_xml(cached_fixture("sparx-instance-specification.xmi")) }

    let(:first_value) do
      first_instance = doc.model.packaged_element.first.packaged_element
        .find { |pe| pe.name == "Object 01" }
      first_slot = first_instance.slot.find { |s| s.defining_feature.end_with?("711E6") }
      first_slot.value.first
    end

    it "parses body from the Object 01 first slot" do
      expect(first_value.body_attribute).to eq("=Value Two")
    end

    it "leaves language_attribute nil (Sparx EA body-attribute form carries no language)" do
      expect(first_value.language_attribute).to be_nil
    end
  end
end
