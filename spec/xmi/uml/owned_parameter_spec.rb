# frozen_string_literal: true

require "spec_helper"
require "xmi"

RSpec.describe Xmi::Uml::OwnedParameter do
  let(:namespace_xml) do
    %(xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:uml="http://www.omg.org/spec/UML/20131001")
  end

  def doc_with(attrs = "")
    <<~XML
      <xmi:XMI #{namespace_xml}>
        <xmi:Documentation exporter="EA"/>
        <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
          <packagedElement xmi:type="uml:Class" xmi:id="EAID_C1" name="Owner">
            <ownedOperation xmi:type="uml:Operation" xmi:id="EAID_OP1" name="op1">
              <ownedParameter xmi:id="EAID_PM1" name="p1" #{attrs}/>
            </ownedOperation>
          </packagedElement>
        </uml:Model>
      </xmi:XMI>
    XML
  end

  def doc_with_children(children)
    <<~XML
      <xmi:XMI #{namespace_xml}>
        <xmi:Documentation exporter="EA"/>
        <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
          <packagedElement xmi:type="uml:Class" xmi:id="EAID_C1" name="Owner">
            <ownedOperation xmi:type="uml:Operation" xmi:id="EAID_OP1" name="op1">
              <ownedParameter xmi:id="EAID_PM1" name="p1">
                #{children}
              </ownedParameter>
            </ownedOperation>
          </packagedElement>
        </uml:Model>
      </xmi:XMI>
    XML
  end

  def owned_parameter(doc)
    doc.model.packaged_element.first.owned_operation.first.owned_parameter.first
  end

  describe "the shared type slot" do
    it "round-trips a general-XMI discriminator unchanged" do
      # The case a non-Sparx consumer depends on. Emitting the
      # unprefixed spelling here would silently rewrite their documents.
      doc = Xmi::Sparx::Root.from_xml(
        doc_with(%(xmi:type="uml:Parameter" direction="return")),
      )
      param = owned_parameter(doc)
      expect(param.type).to eq("uml:Parameter")
      expect(param.to_xml).to include(%(xmi:type="uml:Parameter"))
    end

    it "reads Sparx's unprefixed type reference" do
      doc = Xmi::Sparx::Root.from_xml(doc_with(%(type="EAnone_void" direction="return")))
      expect(owned_parameter(doc).type).to eq("EAnone_void")
    end

    it "re-serializes the Sparx spelling namespaced" do
      # lutaml-model matches attributes by local name, so one slot holds
      # both spellings and only one can come back out. Sparx output is
      # produced by the Sparx exporter, which restores the unprefixed
      # form on its own side.
      doc = Xmi::Sparx::Root.from_xml(doc_with(%(type="EAnone_void" direction="return")))
      expect(owned_parameter(doc).to_xml).to include(%(xmi:type="EAnone_void"))
    end

    it "lets the last type attribute in the input win" do
      doc = Xmi::Sparx::Root.from_xml(
        doc_with(%(type="EAnone_void" xmi:type="uml:Parameter" direction="return")),
      )
      expect(owned_parameter(doc).type).to eq("uml:Parameter")
    end
  end

  describe "Sparx sibling order" do
    # Input lists upperValue FIRST so a pass proves the mapping order —
    # not the input order — controls serialization.
    it "serializes lowerValue before upperValue" do
      doc = Xmi::Sparx::Root.from_xml(doc_with_children(<<~CHILDREN))
        <upperValue xmi:type="uml:LiteralUnlimitedNatural" xmi:id="EAID_U" value="1"/>
        <lowerValue xmi:type="uml:LiteralInteger" xmi:id="EAID_L" value="1"/>
      CHILDREN
      output = owned_parameter(doc).to_xml
      expect(output.index("<lowerValue")).to be < output.index("<upperValue")
    end
  end

  describe "string attributes" do
    it "parses visibility" do
      op = owned_parameter(Xmi::Sparx::Root.from_xml(doc_with('visibility="public"')))
      expect(op.visibility).to eq("public")
    end

    it "parses effect" do
      op = owned_parameter(Xmi::Sparx::Root.from_xml(doc_with('effect="create"')))
      expect(op.effect).to eq("create")
    end

    it "round-trips string attributes" do
      reparsed = Xmi::Sparx::Root.from_xml(
        Xmi::Sparx::Root.from_xml(doc_with('visibility="private" effect="delete"')).to_xml,
      )
      op = owned_parameter(reparsed)
      expect(op.visibility).to eq("private")
      expect(op.effect).to eq("delete")
    end

    it "defaults absent strings to nil" do
      op = owned_parameter(Xmi::Sparx::Root.from_xml(doc_with))
      expect(op.visibility).to be_nil
      expect(op.effect).to be_nil
    end
  end

  describe "boolean flags" do
    it "parses isOrdered=true as true" do
      op = owned_parameter(Xmi::Sparx::Root.from_xml(doc_with('isOrdered="true"')))
      expect(op.is_ordered).to be(true)
    end

    it "parses isUnique=false as false" do
      op = owned_parameter(Xmi::Sparx::Root.from_xml(doc_with('isUnique="false"')))
      expect(op.is_unique).to be(false)
    end

    it "parses isOrdered=1 as true (EA shortcut)" do
      op = owned_parameter(Xmi::Sparx::Root.from_xml(doc_with('isOrdered="1"')))
      expect(op.is_ordered).to be(true)
    end

    it "defaults absent flags to nil" do
      op = owned_parameter(Xmi::Sparx::Root.from_xml(doc_with))
      expect(op.is_ordered).to be_nil
      expect(op.is_unique).to be_nil
    end
  end

  describe "schema" do
    it "declares all is_* flags as :boolean" do
      attrs = described_class.attributes
      expect(attrs[:is_ordered].type).to eq(Lutaml::Model::Type::Boolean)
      expect(attrs[:is_unique].type).to eq(Lutaml::Model::Type::Boolean)
    end
  end
end
