# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Robustness specs for the polymorphic dispatch on Slot#value
# introduced in TODO 10. These lock in current behavior at the
# boundary between the xmi gem and lutaml-model — specifically the
# known edge case where the polymorphic dispatch cannot resolve a
# class.
#
# If lutaml-model is fixed upstream to fall back gracefully, these
# specs will flip and force a conversation about the new behavior.
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
                <value xmi:type="uml:SomethingNew" xmi:id="EAID_X1" body="mystery"/>
              </slot>
            </packagedElement>
          </uml:Model>
        </xmi:XMI>
      XML
    end

    it "currently raises TypeError (lutaml-model const_get nil bug)" do
      # Known upstream issue: lutaml-model's resolve_polymorphic_class
      # calls Object.const_get(nil) when the discriminator is not in
      # the class_map. Tracked in TODO.refactor/13.
      expect { Xmi::Sparx::Root.from_xml(xml) }
        .to raise_error(TypeError, /no implicit conversion of nil into String/)
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
                <value xmi:id="EAID_X1">bare text</value>
              </slot>
            </packagedElement>
          </uml:Model>
        </xmi:XMI>
      XML
    end

    it "currently raises TypeError (lutaml-model const_get nil bug)" do
      expect { Xmi::Sparx::Root.from_xml(xml) }
        .to raise_error(TypeError, /no implicit conversion of nil into String/)
    end
  end
end
# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
