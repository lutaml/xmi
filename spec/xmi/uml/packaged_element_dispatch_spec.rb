# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Verifies the polymorphic dispatch on PackagedElement.packaged_element
# introduced in TODO.next/01 Phase A. Each <packagedElement
# xmi:type="uml:X"> is parsed to a corresponding Xmi::Uml::X subclass.
#
# Phase A: subclasses inherit the full PackagedElement attribute set
# (no narrowing). Phase B will narrow attrs to each subclass's
# UML-2.5-conformant subset.
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "PackagedElement polymorphic dispatch" do
  let(:namespace_xml) do
    %(xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:uml="http://www.omg.org/spec/UML/20131001")
  end

  def doc_with(inner_xml)
    <<~XML
      <xmi:XMI #{namespace_xml}>
        <xmi:Documentation exporter="EA"/>
        <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="M">
          #{inner_xml}
        </uml:Model>
      </xmi:XMI>
    XML
  end

  describe "xmi:type → subclass dispatch" do
    def dispatched_type(xmi_type)
      xml = doc_with(%(<packagedElement xmi:type="#{xmi_type}" xmi:id="EAID_X1" name="thing"/>))
      Xmi::Sparx::Root.from_xml(xml).model.packaged_element.first.class
    end

    it "dispatches uml:Class → UmlClass" do
      expect(dispatched_type("uml:Class")).to eq(Xmi::Uml::UmlClass)
    end

    it "dispatches uml:Association → Association" do
      expect(dispatched_type("uml:Association")).to eq(Xmi::Uml::Association)
    end

    it "dispatches uml:Interface → Interface" do
      expect(dispatched_type("uml:Interface")).to eq(Xmi::Uml::Interface)
    end

    it "dispatches uml:InstanceSpecification → InstanceSpecification" do
      expect(dispatched_type("uml:InstanceSpecification")).to eq(Xmi::Uml::InstanceSpecification)
    end

    it "dispatches uml:DataType → DataType" do
      expect(dispatched_type("uml:DataType")).to eq(Xmi::Uml::DataType)
    end

    it "dispatches uml:PrimitiveType → PrimitiveType" do
      expect(dispatched_type("uml:PrimitiveType")).to eq(Xmi::Uml::PrimitiveType)
    end

    it "dispatches uml:Enumeration → Enumeration" do
      expect(dispatched_type("uml:Enumeration")).to eq(Xmi::Uml::Enumeration)
    end

    it "dispatches uml:Package → Package" do
      expect(dispatched_type("uml:Package")).to eq(Xmi::Uml::Package)
    end

    it "dispatches uml:Realization → Realization" do
      expect(dispatched_type("uml:Realization")).to eq(Xmi::Uml::Realization)
    end
  end

  describe "subclass inheritance" do
    it "all subclasses inherit from PackagedElement" do
      subclasses = [
        Xmi::Uml::UmlClass,
        Xmi::Uml::Association,
        Xmi::Uml::Interface,
        Xmi::Uml::InstanceSpecification,
        Xmi::Uml::DataType,
        Xmi::Uml::PrimitiveType,
        Xmi::Uml::Enumeration,
        Xmi::Uml::Package,
        Xmi::Uml::Realization,
      ]
      expect(subclasses).to all(be < Xmi::Uml::PackagedElement)
    end

    it "subclasses inherit the full attribute set (Phase A)" do
      expect(Xmi::Uml::UmlClass.attributes).to have_key(:owned_attribute)
      expect(Xmi::Uml::Association.attributes).to have_key(:owned_end)
      expect(Xmi::Uml::InstanceSpecification.attributes).to have_key(:slot)
    end
  end

  describe "unknown xmi:type robustness" do
    # Polymorphic dispatch with unknown discriminator falls back to
    # PackagedElement (the union-bag base) via the class_map's
    # default_proc. Avoids the lutaml-model `Object.const_get(nil)`
    # TypeError when Sparx XMI emits a type we haven't modelled yet.
    it "falls back to PackagedElement for unknown xmi:type" do
      xml = doc_with(%(<packagedElement xmi:type="uml:SomethingNew" xmi:id="X1" name="mystery"/>))
      pe = Xmi::Sparx::Root.from_xml(xml).model.packaged_element.first
      expect(pe).to be_a(Xmi::Uml::PackagedElement)
      expect(pe).not_to be_a(Xmi::Uml::UmlClass)
      expect(pe.name).to eq("mystery")
    end

    it "falls back to PackagedElement when xmi:type is missing" do
      xml = doc_with(%(<packagedElement xmi:id="X1" name="bare"/>))
      pe = Xmi::Sparx::Root.from_xml(xml).model.packaged_element.first
      expect(pe).to be_a(Xmi::Uml::PackagedElement)
      expect(pe.name).to eq("bare")
    end

    it "parses Component as Xmi::Uml::Component" do
      xml = doc_with(%(<packagedElement xmi:type="uml:Component" xmi:id="X1" name="svc"/>))
      pe = Xmi::Sparx::Root.from_xml(xml).model.packaged_element.first
      expect(pe).to be_a(Xmi::Uml::Component)
      expect(pe.type).to eq("uml:Component")
    end
  end

  describe "real fixture parity" do
    let(:doc) { Xmi::Sparx::Root.from_xml(cached_fixture("sparx-instance-specification.xmi")) }

    let(:package) { doc.model.packaged_element.first }

    def find_packaged_element(name)
      package.packaged_element.find { |pe| pe.name == name }
    end

    it "parses the 'Objects' root as a Package" do
      expect(package).to be_a(Xmi::Uml::Package)
    end

    it "parses 'Object 01' as an InstanceSpecification" do
      expect(find_packaged_element("Object 01")).to be_a(Xmi::Uml::InstanceSpecification)
    end

    it "parses 'Object 02' as an InstanceSpecification" do
      expect(find_packaged_element("Object 02")).to be_a(Xmi::Uml::InstanceSpecification)
    end

    it "parses 'Link A' as an Association" do
      expect(find_packaged_element("Link A")).to be_a(Xmi::Uml::Association)
    end
  end

  describe "round-trip preserves xmi:type" do
    it "UmlClass round-trips with type=uml:Class" do
      xml = doc_with(%(<packagedElement xmi:type="uml:Class" xmi:id="EAID_C1" name="C"/>))
      reparsed = Xmi::Sparx::Root.from_xml(Xmi::Sparx::Root.from_xml(xml).to_xml)
      pe = reparsed.model.packaged_element.first
      expect(pe).to be_a(Xmi::Uml::UmlClass)
      expect(pe.type).to eq("uml:Class")
    end
  end
end
# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
