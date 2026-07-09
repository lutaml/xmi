# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Robustness specs for the polymorphic dispatch on Slot#value.
# These lock in the graceful-fallback behavior: when the polymorphic
# dispatch cannot resolve a class (unknown or missing xmi:type), it
# falls back to the abstract base class (ValueSpecification) via the
# class_map's Hash default_proc. This avoids the upstream lutaml-model
# `Object.const_get(nil)` TypeError that crashed parsing on real Sparx
# XMI containing types we haven't modelled.
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "Polymorphic Slot#value robustness" do
  let(:namespace_xml) do
    %(xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:uml="http://www.omg.org/spec/UML/20131001")
  end

  describe "unknown xmi:type discriminator" do
    let(:xml) do
      <<~XML
        <xmi:XMI #{namespace_xml}>
          <xmi:Documentation exporter="EA"/>
          <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
            <packagedElement xmi:type="uml:InstanceSpecification" xmi:id="EAID_I1">
              <slot xmi:type="uml:Slot" xmi:id="EAID_SL1" definingFeature="X">
                <value xmi:type="uml:SomethingNew" xmi:id="EAID_X1"/>
              </slot>
            </packagedElement>
          </uml:Model>
        </xmi:XMI>
      XML
    end

    it "falls back to ValueSpecification for unknown xmi:type" do
      value = Xmi::Sparx::Root.from_xml(xml)
        .model.packaged_element.first.slot.first.value.first
      expect(value).to be_a(Xmi::Uml::ValueSpecification)
    end

    it "preserves the unknown xmi:type discriminator string on the value" do
      value = Xmi::Sparx::Root.from_xml(xml)
        .model.packaged_element.first.slot.first.value.first
      expect(value.type).to eq("uml:SomethingNew")
    end
  end

  describe "missing xmi:type discriminator" do
    let(:xml) do
      <<~XML
        <xmi:XMI #{namespace_xml}>
          <xmi:Documentation exporter="EA"/>
          <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
            <packagedElement xmi:type="uml:InstanceSpecification" xmi:id="EAID_I1">
              <slot xmi:type="uml:Slot" xmi:id="EAID_SL1" definingFeature="X">
                <value xmi:id="EAID_X1"/>
              </slot>
            </packagedElement>
          </uml:Model>
        </xmi:XMI>
      XML
    end

    it "falls back to ValueSpecification when xmi:type is missing" do
      value = Xmi::Sparx::Root.from_xml(xml)
        .model.packaged_element.first.slot.first.value.first
      expect(value).to be_a(Xmi::Uml::ValueSpecification)
    end
  end
end
# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
