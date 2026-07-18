# frozen_string_literal: true

require "spec_helper"
require "xmi"

# End-to-end coverage for `<packagedElement xmi:type="uml:InstanceSpecification">`.
# InstanceSpecification is the primary consumer of every feature
# added in this refactor: classifier attribute, slot collection,
# polymorphic slot.value. The fixture is real Sparx EA output
# extracted from lutaml/ea/spec/fixtures/basic.xmi.
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "InstanceSpecification end-to-end" do
  let(:doc) do
    Xmi::Sparx::Root.from_xml(cached_fixture("sparx-instance-specification.xmi"))
  end

  let(:package) { doc.model.packaged_element.first }

  def find_instance(name)
    package.packaged_element.find do |pe|
      pe.type == "uml:InstanceSpecification" && pe.name == name
    end
  end

  describe "Object 01 (InstanceSpecification with two slots)" do
    subject(:first_instance) { find_instance("Object 01") }

    it "is typed as uml:InstanceSpecification" do
      expect(first_instance.type).to eq("uml:InstanceSpecification")
    end

    it "preserves the classifier reference" do
      expect(first_instance.classifier)
        .to eq("EAID_4DEF666F_E8F2_4ace_B9AC_E15A5ACDCADD")
    end

    it "parses both slots" do
      expect(first_instance.slot.size).to eq(2)
    end

    it "dispatches each slot value as a ValueSpecification" do
      first_instance.slot.each do |slot|
        expect(slot.value.first).to be_a(Xmi::Uml::ValueSpecification)
      end
    end

    it "dispatches each slot value as an OpaqueExpression" do
      first_instance.slot.each do |slot|
        expect(slot.value.first).to be_a(Xmi::Uml::OpaqueExpression)
      end
    end

    it "captures the first slot value body" do
      first_slot = first_instance.slot.find { |s| s.defining_feature.end_with?("711E6") }
      expect(first_slot.value.first.body_attribute).to eq("=Value Two")
    end

    it "captures the second slot value body" do
      second_slot = first_instance.slot.find { |s| s.defining_feature.end_with?("5E932") }
      expect(second_slot.value.first.body_attribute).to eq("=Value One")
    end

    it "round-trips the whole instance through serialize → parse" do
      reparsed = Xmi::Sparx::Root.from_xml(Xmi::Sparx::Root.from_xml(doc.to_xml).to_xml)
      reparsed_obj = reparsed.model.packaged_element.first.packaged_element
        .find { |pe| pe.type == "uml:InstanceSpecification" && pe.name == "Object 01" }
      expect(reparsed_obj.slot.size).to eq(2)
      expect(reparsed_obj.classifier).to eq(first_instance.classifier)
    end
  end

  describe "Link A (Association with ownedEnd)" do
    subject(:link_a) do
      package.packaged_element.find { |pe| pe.type == "uml:Association" && pe.name == "Link A" }
    end

    it "parses both ownedEnd children" do
      expect(link_a.owned_end.size).to eq(2)
    end

    it "parses both memberEnd children" do
      expect(link_a.member_ends.size).to eq(2)
    end
  end
end
# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
