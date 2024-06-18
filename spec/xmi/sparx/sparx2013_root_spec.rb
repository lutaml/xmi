# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::SparxRoot2013 do # rubocop:disable Metrics/BlockLength
  context ".from_xml" do # rubocop:disable Metrics/BlockLength
    context "when parsing from XML with XMI 2013 and UML 2013" do
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

      it "should contains Extension" do
        expect(xmi_root_model.extension).to be_instance_of(Xmi::Sparx::SparxExtension2013)
        expect(xmi_root_model.extension.extender).to eq("Enterprise Architect")
        expect(xmi_root_model.extension.profiles).to be_instance_of(Xmi::Sparx::SparxProfiles2013)
        expect(xmi_root_model.extension.profiles.profile).to be_instance_of(Array)
        expect(xmi_root_model.extension.profiles.profile.first).to be_instance_of(Xmi::Uml::Profile2013)
        expect(xmi_root_model.extension.profiles.profile.first.name).to eq("thecustomprofile")
      end
    end

    context "loading EA MDG extension on demand" do # rubocop:disable Metrics/BlockLength
      let(:xml) { File.new(fixtures_path("xmi-v2-4-2-default.xmi")) }
      let(:mdg_definition_xml) { File.new(fixtures_path("ISO19103MDG v1.0.0-beta.xml")) }
      let(:expected_mdg_klasses) do
        %i[
          AbstractSchema
          GI_DataType
          GI_Enumeration
          GI_EnumerationLiteral
          GI_Interface
          GI_Property
          GI_Element
          GI_Class
          GI_CodeSet
        ].sort
      end

      let(:expect_orig_attributes) do
        %i[
          id
          label
          uuid
          href
          idref
          type
          extension
          publication_date
          edition
          number
          year_version
          modelica_parameter
        ].sort
      end

      let(:expect_orig_xml_mapping) do
        %w[
          http://www.omg.org/spec/XMI/20131001:Documentation
          http://www.omg.org/spec/UML/20131001:Model
          http://www.omg.org/spec/XMI/20131001:Extension
          http://www.sparxsystems.com/profiles/thecustomprofile/1.0:publicationDate
          http://www.sparxsystems.com/profiles/thecustomprofile/1.0:edition
          http://www.sparxsystems.com/profiles/thecustomprofile/1.0:number
          http://www.sparxsystems.com/profiles/thecustomprofile/1.0:yearVersion
          http://www.sparxsystems.com/profiles/SysPhS/1.0:ModelicaParameter
        ]
      end

      let(:xmi_root_model) { described_class.from_xml(File.read(xml)) }

      context "before loading extension" do
        it "should not contain Mdg module" do
          ea_modules = Xmi::EaRoot.constants.select do |c|
            Xmi::EaRoot.const_get(c).is_a? Module
          end

          expect(ea_modules).to be_empty
        end
      end

      context "after loading extension" do # rubocop:disable Metrics/BlockLength
        before do
          Xmi::EaRoot.load_mdg_extension(mdg_definition_xml)
        end

        it "should contain Mdg module" do
          ea_modules = Xmi::EaRoot.constants.select do |c|
            Xmi::EaRoot.const_get(c).is_a? Module
          end

          expect(ea_modules).not_to be_empty
        end

        it "should create Mdg classes dynamically" do
          mdg_klasses = Xmi::EaRoot::Mdg.constants.select do |c|
            Xmi::EaRoot::Mdg.const_get(c).is_a? Class
          end

          expect(mdg_klasses.sort).to eq(
            expected_mdg_klasses.map { |k| Shale::Utils.classify(k).to_sym }
          )
        end

        it "should contains original attributes" do
          expect_orig_attributes.each do |k|
            expect(Xmi::Sparx::SparxRoot2013.attributes).to have_key(Shale::Utils.snake_case(k).to_sym)
          end
        end

        it "should contains new attributes" do
          expected_mdg_klasses.each do |k|
            expect(Xmi::Sparx::SparxRoot2013.attributes).to have_key(Shale::Utils.snake_case(k).to_sym)
          end
        end

        it "should contains original xml mapping" do
          expect_orig_xml_mapping.each do |element_key|
            expect(Xmi::Sparx::SparxRoot2013.xml_mapping.elements).to have_key(element_key)
          end
        end

        it "should contains new xml mapping" do
          expected_mdg_klasses.each do |k|
            next if k == :GI_Element

            element_key = "https://standards.isotc211.org/19103/-/2/uml-profile:#{k}"
            expect(Xmi::Sparx::SparxRoot2013.xml_mapping.elements).to have_key(element_key)
          end
        end

        mdg_test = [
          {
            klass: "Xmi::EaRoot::Mdg::AbstractSchema",
            attribute: "abstract_schema",
            method: "base_package",
            value: "EAPK_63F21616_57B0_4ffc_A785_8FB5B49C27F1"
          },
          {
            klass: "Xmi::EaRoot::Mdg::GIInterface",
            attribute: "gi_interface",
            method: "base_interface",
            value: "EAID_1EA35B7C_1E09_4fe5_B75D_515CA12171B9"
          },
          {
            klass: "Xmi::EaRoot::Mdg::GIProperty",
            attribute: "gi_property",
            method: "base_property",
            value: "EAID_2A7400AC_F474_4063_A5B9_5C5305020D60"
          },
          {
            klass: "Xmi::EaRoot::Mdg::GIEnumeration",
            attribute: "gi_enumeration",
            method: "base_enumeration",
            value: "EAID_5AC15946_7E2E_4d2e_8208_300138B764C9"
          },
          {
            klass: "Xmi::EaRoot::Mdg::GIEnumerationLiteral",
            attribute: "gi_enumeration_literal",
            method: "base_enumeration_literal",
            value: "EAID_44EAA54D_A02D_4263_9EBF_C67721A40BAA"
          }
        ]

        mdg_test.each do |t|
          it "should contains #{t[:klass]}" do
            expect(xmi_root_model.send(t[:attribute].to_sym))
              .to be_instance_of(Array)
            expect(xmi_root_model.send(t[:attribute].to_sym).first.class.name)
              .to eq(t[:klass])
            expect(xmi_root_model.send(t[:attribute].to_sym).first
              .send(t[:method].to_sym)).to eq(t[:value])
          end
        end
      end
    end
  end
end
