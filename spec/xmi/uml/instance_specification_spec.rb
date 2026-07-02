# frozen_string_literal: true

require "spec_helper"
require "xmi"

# End-to-end coverage for `<packagedElement xmi:type="uml:InstanceSpecification">`.
# InstanceSpecification is the primary consumer of every feature
# added in this refactor: classifier attribute, slot collection,
# polymorphic slot.value, and specification text content. This spec
# ties TODOs 02 (classifier), 03 (slot), 10 (polymorphic value), and
# 12 (specification content) into a single integration test.
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "InstanceSpecification end-to-end" do
  let(:doc) do
    Xmi::Sparx::Root.from_xml(cached_fixture("sparx-instance-specification.xmi"))
  end

  let(:package) { doc.model.packaged_element.first }

  def find_instance(name)
    package.packaged_element.find { |pe| pe.type == "uml:InstanceSpecification" && pe.name == name }
  end

  describe "alice (InstanceSpecification with two slots)" do
    subject(:alice) { find_instance("alice") }

    it "is typed as uml:InstanceSpecification" do
      expect(alice.type).to eq("uml:InstanceSpecification")
    end

    it "preserves the classifier reference" do
      expect(alice.classifier)
        .to eq("EAID_AA000000_0000_0000_0000_000000000002")
    end

    it "parses both slots" do
      expect(alice.slot.size).to eq(2)
    end

    it "dispatches each slot value as a ValueSpecification" do
      alice.slot.each do |slot|
        expect(slot.value.first).to be_a(Xmi::Uml::ValueSpecification)
      end
    end

    it "captures the name slot value body" do
      name_slot = alice.slot.find { |s| s.defining_feature.end_with?("0000003") }
      expect(name_slot.value.first.body_attribute).to eq("Alice")
    end

    it "captures the age slot value body and language" do
      age_slot = alice.slot.find { |s| s.defining_feature.end_with?("0000004") }
      value = age_slot.value.first
      expect(value.body_attribute).to eq("42")
      expect(value.language_attribute).to eq("OCL")
    end

    it "round-trips the whole instance through serialize → parse" do
      reparsed = Xmi::Sparx::Root.from_xml(Xmi::Sparx::Root.from_xml(doc.to_xml).to_xml)
      reparsed_alice = reparsed.model.packaged_element.first.packaged_element
        .find { |pe| pe.type == "uml:InstanceSpecification" && pe.name == "alice" }
      expect(reparsed_alice.slot.size).to eq(2)
      expect(reparsed_alice.classifier).to eq(alice.classifier)
    end
  end

  describe "constraintHolder (InstanceSpecification with specification text)" do
    subject(:holder) { find_instance("constraintHolder") }

    it "parses the specification element" do
      expect(holder.specification).to be_a(Xmi::Uml::Specification)
    end

    it "captures the specification language attribute" do
      expect(holder.specification.language).to eq("OCL")
    end

    it "captures the specification text content" do
      expect(holder.specification.content).to include("context Person inv")
      expect(holder.specification.content).to include("self.age >= 0")
    end

    it "round-trips the specification text content" do
      reparsed = Xmi::Sparx::Root.from_xml(Xmi::Sparx::Root.from_xml(doc.to_xml).to_xml)
      reparsed_holder = reparsed.model.packaged_element.first.packaged_element
        .find { |pe| pe.name == "constraintHolder" }
      expect(reparsed_holder.specification.content).to include("context Person inv")
    end
  end
end
# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
