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
    # Polymorphic dispatch with unknown discriminator currently raises
    # TypeError (lutaml-model const_get nil). See TODO.next/02 and the
    # polymorphic_robustness_spec.rb lock-in.
    it "raises TypeError for unknown xmi:type" do
      xml = doc_with(%(<packagedElement xmi:type="uml:SomethingNew" xmi:id="X1"/>))
      expect { Xmi::Sparx::Root.from_xml(xml) }
        .to raise_error(TypeError, /no implicit conversion of nil into String/)
    end
  end

  describe "real fixture parity" do
    let(:doc) { Xmi::Sparx::Root.from_xml(cached_fixture("sparx-instance-specification.xmi")) }

    it "parses the Person packagedElement as a UmlClass" do
      person = doc.model.packaged_element.first.packaged_element
        .find { |pe| pe.name == "Person" }
      expect(person).to be_a(Xmi::Uml::UmlClass)
    end

    it "parses the IGreetable packagedElement as an Interface" do
      iface = doc.model.packaged_element.first.packaged_element
        .find { |pe| pe.name == "IGreetable" }
      expect(iface).to be_a(Xmi::Uml::Interface)
    end

    it "parses the alice packagedElement as an InstanceSpecification" do
      alice = doc.model.packaged_element.first.packaged_element
        .find { |pe| pe.name == "alice" }
      expect(alice).to be_a(Xmi::Uml::InstanceSpecification)
    end

    it "parses the 'instances' root as a Package" do
      expect(doc.model.packaged_element.first).to be_a(Xmi::Uml::Package)
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
