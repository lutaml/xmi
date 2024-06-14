# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::SparxRoot do
  context ".from_xml" do
    context "when parsing from XML with XMI 2013 and UML 2016" do
      let(:xml) { File.new(fixtures_path("ISO 6709 Edition 2.xml")) }

      subject(:xmi_root_model) { described_class.from_xml(File.read(xml)) }

      it { is_expected.to be_instance_of(Xmi::Sparx::SparxRoot) }

      it "should contains Documentation" do
        expect(xmi_root_model.documentation).to be_instance_of(Xmi::Documentation)
        expect(xmi_root_model.documentation.exporter).to eq("Enterprise Architect")
      end

      it "should contains Model" do
        expect(xmi_root_model.model).to be_instance_of(Xmi::Uml::UmlModel)
        expect(xmi_root_model.model.name).to eq("EA_Model")
        expect(xmi_root_model.model.packaged_element).to be_instance_of(Array)
        expect(xmi_root_model.model.packaged_element.first).to be_instance_of(Xmi::Uml::PackagedElement)
        expect(xmi_root_model.model.packaged_element.first.name).to eq("ISO 6709 Edition 2")
      end

      it "should contains Extension" do
        expect(xmi_root_model.extension).to be_instance_of(Xmi::Sparx::SparxExtension)
        expect(xmi_root_model.extension.extender).to eq("Enterprise Architect")
        expect(xmi_root_model.extension.profiles).to be_instance_of(Xmi::Sparx::SparxProfiles)
        expect(xmi_root_model.extension.profiles.profile).to be_instance_of(Array)
        expect(xmi_root_model.extension.profiles.profile.first).to be_instance_of(Xmi::Uml::Profile)
        expect(xmi_root_model.extension.profiles.profile.first.name).to eq("thecustomprofile")
      end
    end
  end
end
