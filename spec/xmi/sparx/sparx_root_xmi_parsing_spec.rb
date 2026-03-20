# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::SparxRoot do # rubocop:disable Metrics/BlockLength
  describe ".parse_xml" do
    context "with ea-xmi-2.5.1.xmi (XMI 20110701)" do
      subject!(:xmi_root_model) { described_class.parse_xml(xml_content) }

      let(:xml_content) { cached_fixture("ea-xmi-2.5.1.xmi") }

      it { is_expected.to be_instance_of(described_class) }

      it "contains Documentation" do
        expect(xmi_root_model.documentation).to be_instance_of(Xmi::Documentation)
        expect(xmi_root_model.documentation.exporter).to eq("Enterprise Architect")
      end

      it "contains Model" do
        expect(xmi_root_model.model).to be_instance_of(Xmi::Uml::UmlModel)
        expect(xmi_root_model.model.name).to eq("EA_Model")
        expect(xmi_root_model.model.packaged_element).to be_instance_of(Array)
        expect(xmi_root_model.model.packaged_element.first).to be_instance_of(Xmi::Uml::PackagedElement)
        expect(xmi_root_model.model.packaged_element.first.name).to eq("requirement type class diagram")
      end

      it "contains memberEnd element in packaged_element" do
        element = xmi_root_model.model.packaged_element.first
          .packaged_element[1].member_ends.first
        expect(element.idref).to eq("EAID_dstA98919_831B_4182_BBC2_C2EAF17FEF60")
      end

      it "contains memberEnd attribute in packaged_element" do
        element = xmi_root_model
          .extension.profiles.profile.first.packaged_element[1]
        expect(element.member_end).to eq("extension_BasicDoc BasicDoc-base_Class")
      end

      it "contains Extension" do
        expect(xmi_root_model.extension).to be_instance_of(Xmi::Sparx::Extension)
        expect(xmi_root_model.extension.extender).to eq("Enterprise Architect")
        expect(xmi_root_model.extension.profiles).to be_instance_of(Xmi::Sparx::CustomProfile::Profiles)
        expect(xmi_root_model.extension.profiles.profile).to be_instance_of(Array)
        expect(xmi_root_model.extension.profiles.profile.first).to be_instance_of(Xmi::Uml::Profile)
        expect(xmi_root_model.extension.profiles.profile.first.name).to eq("thecustomprofile")
      end
    end

    context "with ISO 6709 Edition 2.xml (XMI 20131001 + UML 20161101)" do
      subject!(:xmi_root_model) { described_class.parse_xml(xml_content) }

      let(:xml_content) { cached_fixture("ISO 6709 Edition 2.xml") }
      let(:xml_output) { xmi_root_model.to_xml }
      let(:moxml_context) { Moxml.new }
      let(:xml_doc) { moxml_context.parse(xml_output) }

      it { is_expected.to be_instance_of(described_class) }

      it "contains Documentation" do
        expect(xmi_root_model.documentation).to be_instance_of(Xmi::Documentation)
        expect(xmi_root_model.documentation.exporter).to eq("Enterprise Architect")
      end

      it "contains Model" do
        expect(xmi_root_model.model).to be_instance_of(Xmi::Uml::UmlModel)
        expect(xmi_root_model.model.name).to eq("EA_Model")
        expect(xmi_root_model.model.packaged_element).to be_instance_of(Array)
        expect(xmi_root_model.model.packaged_element.first).to be_instance_of(Xmi::Uml::PackagedElement)
        expect(xmi_root_model.model.packaged_element.first.name).to eq("ISO 6709 Edition 2")
      end

      it "contains Extension" do
        expect(xmi_root_model.extension).to be_instance_of(Xmi::Sparx::Extension)
        expect(xmi_root_model.extension.extender).to eq("Enterprise Architect")
        expect(xmi_root_model.extension.profiles).to be_instance_of(Xmi::Sparx::CustomProfile::Profiles)
        expect(xmi_root_model.extension.profiles.profile).to be_instance_of(Array)
        expect(xmi_root_model.extension.profiles.profile.first).to be_instance_of(Xmi::Uml::Profile)
        expect(xmi_root_model.extension.profiles.profile.first.name).to eq("thecustomprofile")
      end

      describe ".to_xml" do
        it "is able to output XML properly" do
          namespaces = {
            "xmi" => "http://www.omg.org/spec/XMI/20131001",
            "uml" => "http://www.omg.org/spec/UML/20131001",
            "thecustomprofile" => "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
          }

          key_elements = [
            "//xmi:XMI",
            "//xmi:Documentation",
            "//uml:Model",
            "//uml:Model/uml:packagedElement",
            "//uml:Model/uml:profileApplication",
            "//xmi:Extension",
            "//xmi:Extension/elements/element",
            "//thecustomprofile:edition",
          ]

          key_elements.each do |path|
            nodes = xml_doc.xpath(path, namespaces)
            expect(nodes).not_to be_empty,
                                 "Expected to find nodes at XPath: #{path}"
          end

          model = xml_doc.xpath("//uml:Model", namespaces).first
          expect(model["name"]).to eq("EA_Model")
          expect(model["xmi:type"]).to eq("uml:Model")

          packaged = xml_doc.xpath("//uml:Model/uml:packagedElement", namespaces).first
          expect(packaged["name"]).to eq("ISO 6709 Edition 2")
          expect(packaged["xmi:type"]).to eq("uml:Package")

          extension = xml_doc.xpath("//xmi:Extension", namespaces).first
          expect(extension["extender"]).to eq("Enterprise Architect")

          edition = xml_doc.xpath("//thecustomprofile:edition", namespaces).first
          expect(edition["edition"]).to eq("2")
          expect(edition["base_Package"]).to eq("EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB")
        end
      end
    end

    context "with large_test.xmi (XMI 20131001 + UML 20161101)" do
      subject!(:xmi_root_model) { described_class.parse_xml(xml_content) }

      let(:citygml_definition_xml) { fixtures_path("CityGML_MDG_Technology.xml") }
      let(:xml_content) { cached_fixture("large_test.xmi") }

      it { is_expected.to be_instance_of(described_class) }

      it "contains EAStub in Extension" do
        expect(xmi_root_model.extension.ea_stub).to be_instance_of(Array)
        expect(xmi_root_model.extension.ea_stub.first).to be_instance_of(Xmi::Sparx::EaStub)
        expect(xmi_root_model.extension.ea_stub.first.id).to eq("EAID_5F1B0A70_92F5_42ef_9431_155EB96F7E5D")
        expect(xmi_root_model.extension.ea_stub.first.name).to eq("Date")
        expect(xmi_root_model.extension.ea_stub.first.uml_type).to eq("Interface")
      end
    end
  end
end
