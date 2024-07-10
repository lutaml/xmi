# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::SparxRoot2013 do # rubocop:disable Metrics/BlockLength
  context ".from_xml" do # rubocop:disable Metrics/BlockLength
    context "when parsing from XML with XMI 2013 and UML 2013" do # rubocop:disable Metrics/BlockLength
      let(:xml) { File.new(fixtures_path("ea-xmi-2.5.1.xmi")) }

      subject(:xmi_root_model) { described_class.from_xml(File.read(xml)) }

      it { is_expected.to be_instance_of(Xmi::Sparx::SparxRoot2013) }

      it "should contains Documentation" do
        expect(xmi_root_model.documentation).to be_instance_of(Xmi::Documentation)
        expect(xmi_root_model.documentation.exporter).to eq("Enterprise Architect")
      end

      it "should contains Model" do
        expect(xmi_root_model.model).to be_instance_of(Xmi::Uml::UmlModel2013)
        expect(xmi_root_model.model.name).to eq("EA_Model")
        expect(xmi_root_model.model.packaged_element).to be_instance_of(Array)
        expect(xmi_root_model.model.packaged_element.first).to be_instance_of(Xmi::Uml::PackagedElement2013)
        expect(xmi_root_model.model.packaged_element.first.name).to eq("requirement type class diagram")
      end

      it "should contains memberEnd element in packaged_element" do
        element = xmi_root_model.model.packaged_element.first
                                .packaged_element[1].member_ends.first
        expect(element.idref).to eq("EAID_dstA98919_831B_4182_BBC2_C2EAF17FEF60")
      end

      it "should contains memberEnd attribute in packaged_element" do
        element = xmi_root_model
                  .extension.profiles.profile.first.packaged_element[1]
        expect(element.member_end).to eq("extension_BasicDoc BasicDoc-base_Class")
      end

      it "should contains Extension" do
        expect(xmi_root_model.extension).to be_instance_of(Xmi::Sparx::SparxExtension2013)
        expect(xmi_root_model.extension.extender).to eq("Enterprise Architect")
        expect(xmi_root_model.extension.profiles).to be_instance_of(Xmi::Sparx::SparxProfiles2013)
        expect(xmi_root_model.extension.profiles.profile).to be_instance_of(Array)
        expect(xmi_root_model.extension.profiles.profile.first).to be_instance_of(Xmi::Uml::Profile2013)
        expect(xmi_root_model.extension.profiles.profile.first.name).to eq("thecustomprofile")
      end
    end
  end
end
