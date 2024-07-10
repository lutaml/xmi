# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::SparxRoot2013 do # rubocop:disable Metrics/BlockLength
  context ".from_xml" do # rubocop:disable Metrics/BlockLength
    context "loading EA GML extension on demand" do # rubocop:disable Metrics/BlockLength
      let(:xml) { File.new(fixtures_path("xmi-v2-4-2-default-with-gml.xmi")) }
      let(:gml_definition_xml) { File.new(fixtures_path("GML.xml")) }
      let(:expected_gml_klasses) do
        %i[
          ApplicationSchema
          CodeList
          Property
        ].sort
      end

      let(:expected_gml_keys) do
        %i[
          ApplicationSchema
          CodeList
          property
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
        it "should not contain Gml module" do
          ea_modules = Xmi::EaRoot.constants.select do |c|
            Xmi::EaRoot.const_get(c).is_a? Module
          end

          expect(ea_modules).to be_empty
        end
      end

      context "after loading extension" do # rubocop:disable Metrics/BlockLength
        before do
          Xmi::EaRoot.load_extension(gml_definition_xml)
        end

        after do
          Xmi::EaRoot.send(:remove_const, "Gml")
        end

        it "should contain Gml module" do
          ea_modules = Xmi::EaRoot.constants.select do |c|
            Xmi::EaRoot.const_get(c).is_a? Module
          end

          expect(ea_modules).not_to be_empty
        end

        it "should create Gml classes dynamically" do
          gml_klasses = Xmi::EaRoot::Gml.constants.select do |c|
            Xmi::EaRoot::Gml.const_get(c).is_a? Class
          end

          expect(gml_klasses.sort).to eq(
            expected_gml_klasses.map { |k| Shale::Utils.classify(k).to_sym }
          )
        end

        it "should contains original attributes" do
          expect_orig_attributes.each do |k|
            expect(Xmi::Sparx::SparxRoot2013.attributes).to have_key(Shale::Utils.snake_case(k).to_sym)
          end
        end

        it "should contains new attributes" do
          expected_gml_klasses.each do |k|
            expect(Xmi::Sparx::SparxRoot2013.attributes).to have_key(Shale::Utils.snake_case(k).to_sym)
          end
        end

        it "should contains original xml mapping" do
          expect_orig_xml_mapping.each do |element_key|
            expect(Xmi::Sparx::SparxRoot2013.xml_mapping.elements).to have_key(element_key)
          end
        end

        it "should contains new xml mapping" do
          expected_gml_keys.each do |k|
            element_key = "http://www.sparxsystems.com/profiles/GML/1.0:#{k}"
            expect(Xmi::Sparx::SparxRoot2013.xml_mapping.elements).to have_key(element_key)
          end
        end

        gml_test = [
          {
            klass: "Xmi::EaRoot::Gml::ApplicationSchema",
            attribute: "application_schema",
            method: "base_package",
            value: "EAPK_511CFB07_CCBA_4005_B3CD_B18A5A29767A"
          },
          {
            klass: "Xmi::EaRoot::Gml::CodeList",
            attribute: "code_list",
            method: "base_class",
            value: "EAID_65257DDE_3F0E_4c31_8026_17D78B6F4D23"
          },
          {
            klass: "Xmi::EaRoot::Gml::Property",
            attribute: "property",
            method: "base_property",
            value: "EAID_648276FD_A507_4d93_8253_F04D7D35A576"
          }
        ]

        gml_test.each do |t|
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
