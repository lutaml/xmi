# frozen_string_literal: true

require "spec_helper"
require "xmi"

RSpec.describe Xmi::Uml::OwnedOperation do
  let(:namespace_xml) do
    %(xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:uml="http://www.omg.org/spec/UML/20131001")
  end

  def doc_with(attrs = "")
    <<~XML
      <xmi:XMI #{namespace_xml}>
        <xmi:Documentation exporter="EA"/>
        <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
          <packagedElement xmi:type="uml:Class" xmi:id="EAID_C1" name="Owner">
            <ownedOperation xmi:type="uml:Operation" xmi:id="EAID_OP1" name="op1" #{attrs}/>
          </packagedElement>
        </uml:Model>
      </xmi:XMI>
    XML
  end

  def owned_operation(doc)
    doc.model.packaged_element.first.owned_operation.first
  end

  describe "string attributes" do
    it "parses visibility" do
      oo = owned_operation(Xmi::Sparx::Root.from_xml(doc_with('visibility="public"')))
      expect(oo.visibility).to eq("public")
    end

    it "parses concurrency" do
      oo = owned_operation(Xmi::Sparx::Root.from_xml(doc_with('concurrency="sequential"')))
      expect(oo.concurrency).to eq("sequential")
    end

    it "round-trips string attributes" do
      reparsed = Xmi::Sparx::Root.from_xml(
        Xmi::Sparx::Root.from_xml(doc_with('visibility="protected" concurrency="guarded"')).to_xml,
      )
      oo = owned_operation(reparsed)
      expect(oo.visibility).to eq("protected")
      expect(oo.concurrency).to eq("guarded")
    end

    it "defaults absent strings to nil" do
      oo = owned_operation(Xmi::Sparx::Root.from_xml(doc_with))
      expect(oo.visibility).to be_nil
      expect(oo.concurrency).to be_nil
    end
  end

  describe "boolean flags" do
    it "parses isStatic=true as true" do
      oo = owned_operation(Xmi::Sparx::Root.from_xml(doc_with('isStatic="true"')))
      expect(oo.is_static).to be(true)
    end

    it "parses isAbstract=true as true" do
      oo = owned_operation(Xmi::Sparx::Root.from_xml(doc_with('isAbstract="true"')))
      expect(oo.is_abstract).to be(true)
    end

    it "parses isQuery=true as true" do
      oo = owned_operation(Xmi::Sparx::Root.from_xml(doc_with('isQuery="true"')))
      expect(oo.is_query).to be(true)
    end

    it "parses isStatic=0 as false (EA shortcut)" do
      oo = owned_operation(Xmi::Sparx::Root.from_xml(doc_with('isStatic="0"')))
      expect(oo.is_static).to be(false)
    end

    it "defaults absent flags to nil" do
      oo = owned_operation(Xmi::Sparx::Root.from_xml(doc_with))
      expect(oo.is_static).to be_nil
      expect(oo.is_abstract).to be_nil
      expect(oo.is_query).to be_nil
    end
  end

  describe "schema" do
    it "declares all is_* flags as :boolean" do
      attrs = described_class.attributes
      expect(attrs[:is_static].type).to eq(Lutaml::Model::Type::Boolean)
      expect(attrs[:is_abstract].type).to eq(Lutaml::Model::Type::Boolean)
      expect(attrs[:is_query].type).to eq(Lutaml::Model::Type::Boolean)
    end

    it "declares visibility/concurrency as :string" do
      attrs = described_class.attributes
      expect(attrs[:visibility].type).to eq(Lutaml::Model::Type::String)
      expect(attrs[:concurrency].type).to eq(Lutaml::Model::Type::String)
    end
  end
end
