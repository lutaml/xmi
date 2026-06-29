# frozen_string_literal: true

require "spec_helper"
require "xmi"
require "nokogiri"

# Sparx EA XMI uses a mixed-prefix style that is unusual:
#
#   <xmi:XMI xmlns:xmi="..." xmlns:uml="...">
#     <xmi:Documentation .../>
#     <uml:Model xmi:type="uml:Model" name="EA_Model">
#       <packagedElement xmi:type="uml:Package" ...>    <!-- UNPREFIXED -->
#         <ownedAttribute ...>                           <!-- UNPREFIXED -->
#           <type xmi:idref="..."/>                      <!-- UNPREFIXED -->
#           <upperValue .../>                            <!-- UNPREFIXED -->
#         </ownedAttribute>
#       </packagedElement>
#     </uml:Model>
#   </xmi:XMI>
#
# Only <xmi:XMI>, <xmi:Documentation>, and <uml:Model> are prefixed.
# Every other UML element is unprefixed — even though it lives in the
# UML namespace by inheritance from <uml:Model>.
#
# This is the canonical Sparx output shape and what the xmi gem must
# reproduce when serializing for Sparx round-trip fidelity.
RSpec.describe "Sparx mixed-prefix serialization style" do
  let(:xml) { cached_fixture("ea-xmi-2.5.1.xmi") }
  let(:doc) { Xmi::Sparx::Root.from_xml(xml) }
  let(:output) { doc.to_xml(use_prefix: true) }
  let(:parsed) { Nokogiri::XML(output) }

  def prefix_of(tag)
    node = parsed.at_xpath("//*[local-name()='#{tag}']")
    node&.namespace&.prefix
  end

  describe "prefixed elements (kept in their namespace)" do
    it "serializes <xmi:XMI> with the xmi prefix" do
      expect(parsed.root.namespace.prefix).to eq("xmi")
    end

    it "serializes <Documentation> with the xmi prefix" do
      expect(prefix_of("Documentation")).to eq("xmi")
    end

    it "serializes <Model> with the uml prefix" do
      expect(prefix_of("Model")).to eq("uml")
    end
  end

  describe "unprefixed UML child elements (Sparx mixed-prefix style)" do
    [
      "packagedElement",
      "ownedAttribute",
      "ownedEnd",
      "memberEnd",
      "generalization",
      "ownedComment",
      "annotatedElement",
      "type",
      "upperValue",
      "lowerValue",
      "ownedLiteral",
      "ownedOperation",
      "ownedParameter",
    ].each do |tag|
      it "serializes <#{tag}> with no prefix" do
        expect(prefix_of(tag)).to be_nil,
                                  "expected <#{tag}> to be unprefixed, got #{prefix_of(tag).inspect}"
      end
    end
  end

  describe "xmi: attributes preserved on unprefixed elements" do
    it "keeps xmi:type on <packagedElement>" do
      pe = parsed.at_xpath("//*[local-name()='packagedElement']")
      expect(pe["xmi:type"]).to eq("uml:Package")
    end

    it "keeps xmi:id on <packagedElement>" do
      pe = parsed.at_xpath("//*[local-name()='packagedElement']")
      expect(pe["xmi:id"]).to match(/\AEAPK_/),
                              "expected EAPK_ prefix, got #{pe['xmi:id'].inspect}"
    end

    it "keeps xmi:idref on <memberEnd>" do
      me = parsed.at_xpath("//*[local-name()='memberEnd']")
      expect(me["xmi:idref"]).to match(/\AEAID_/),
                                 "expected EAID_ prefix, got #{me['xmi:idref'].inspect}"
    end

    it "keeps xmi:type on <ownedAttribute>" do
      oa = parsed.at_xpath("//*[local-name()='ownedAttribute']")
      expect(oa["xmi:type"]).to eq("uml:Property")
    end
  end

  describe "no xmlns=\"\" declarations on unprefixed children" do
    it "does not emit xmlns='' on any packagedElement" do
      parsed.xpath("//*[local-name()='packagedElement']").each do |pe|
        expect(pe.attribute_with_ns("xmlns", nil)&.value).to be_nil | eq(""),
                                                             "unexpected xmlns='' on <packagedElement> xmi:id=#{pe['xmi:id']}"
      end
    end
  end
end
