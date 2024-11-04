# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::SparxRoot do # rubocop:disable Metrics/BlockLength
  context ".parse_xml" do # rubocop:disable Metrics/BlockLength
    context "loading EA CityGML extension on demand" do # rubocop:disable Metrics/BlockLength
      let(:xml) { File.new(fixtures_path("full-242.xmi")) }
      let(:citygml_definition_xml) { File.new(fixtures_path("CityGML_MDG_Technology.xml")) }
      let(:expected_citygml_klasses) do
        %i[
          FeatureType
          CodeList
          Leaf
          ObjectType
          BasicType
          TopLevelFeatureType
          Union
          Property
          Version
          ApplicationSchema
          DataType
        ].sort
      end

      let(:expected_citygml_keys) do
        %i[
          FeatureType
          CodeList
          Leaf
          ObjectType
          BasicType
          TopLevelFeatureType
          Union
          Property
          Version
          ApplicationSchema
          DataType
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

      let(:xmi_root_model) { described_class.parse_xml(File.read(xml)) }

      context "before loading extension" do
        it "should not contain Citygml module" do
          ea_modules = Xmi::EaRoot.constants.select do |c|
            Xmi::EaRoot.const_get(c).is_a?(Module) && c != :Gml && c != :Eauml
          end

          expect(ea_modules).to be_empty
        end
      end

      context "after loading extension" do # rubocop:disable Metrics/BlockLength
        before do
          Xmi::EaRoot.load_extension(citygml_definition_xml)
        end

        after do
          Xmi::EaRoot.send(:remove_const, "Citygml")
        end

        it "should contain Citygml module" do
          ea_modules = Xmi::EaRoot.constants.select do |c|
            Xmi::EaRoot.const_get(c).is_a? Module
          end

          expect(ea_modules).not_to be_empty
        end

        it "should create Citygml classes dynamically" do
          citygml_klasses = Xmi::EaRoot::Citygml.constants.select do |c|
            Xmi::EaRoot::Citygml.const_get(c).is_a? Class
          end

          expect(citygml_klasses.sort).to eq(
            expected_citygml_klasses.map { |k| Lutaml::Model::Utils.classify(k).to_sym }
          )
        end

        it "should contains original attributes" do
          expect_orig_attributes.each do |k|
            expect(Xmi::Sparx::SparxRoot.attributes).to have_key(Lutaml::Model::Utils.snake_case(k).to_sym)
          end
        end

        it "should contains new attributes" do
          expected_citygml_klasses.each do |k|
            expect(Xmi::Sparx::SparxRoot.attributes).to have_key(Lutaml::Model::Utils.snake_case(k).to_sym)
          end
        end

        it "should contains original xml mapping" do
          expect_orig_xml_mapping.each do |element_key|
            mappings = Xmi::Sparx::SparxRoot
                       .mappings_for(:xml).elements.map do |e|
              ns = e.namespace || e.default_namespace
              "#{ns}:#{e.name}"
            end

            expect(mappings).to include(element_key)
          end
        end

        it "should contains new xml mapping" do
          expected_citygml_keys.each do |k|
            element_key = "http://www.sparxsystems.com/profiles/CityGML/1.0:#{k}"

            mappings = Xmi::Sparx::SparxRoot
                       .mappings_for(:xml).elements.map do |e|
              ns = e.namespace || e.default_namespace
              "#{ns}:#{e.name}"
            end

            expect(mappings).to include(element_key)
          end
        end

        citygml_test = [
          {
            klass: "Xmi::EaRoot::Citygml::ApplicationSchema",
            attribute: "application_schema",
            method: "base_package",
            value: "EAPK_1C8607D1_2967_44ff_948A_2A9256D00A45"
          },
          {
            klass: "Xmi::EaRoot::Citygml::CodeList",
            attribute: "code_list",
            method: "base_class",
            value: "EAID_63F44B99_981E_41ba_8BF9_0B7231BD321A"
          },
          {
            klass: "Xmi::EaRoot::Citygml::Property",
            attribute: "property",
            method: "base_property",
            value: "EAID_08C9C0B1_5EF2_498b_9615_D83FFF295CE4"
          },
          {
            klass: "Xmi::EaRoot::Citygml::FeatureType",
            attribute: "feature_type",
            method: "base_class",
            value: "EAID_D8E4EAFC_9DAF_4cba_9169_984738657435"
          },
          {
            klass: "Xmi::EaRoot::Citygml::TopLevelFeatureType",
            attribute: "top_level_feature_type",
            method: "base_class",
            value: "EAID_645EA139_9F9D_4caf_90C3_3455836FA55B"
          },
          {
            klass: "Xmi::EaRoot::Citygml::DataType",
            attribute: "data_type",
            method: "base_data_type",
            value: "EAID_4661534F_B67D_46b5_BC56_CEED3792F85B"
          },
          {
            klass: "Xmi::EaRoot::Citygml::Version",
            attribute: "version",
            method: "base_property",
            value: "EAID_dst1B1F37_56A4_4908_B024_75F617AEE928"
          },
          {
            klass: "Xmi::EaRoot::Citygml::BasicType",
            attribute: "basic_type",
            method: "base_class",
            value: "EAID_055FE569_234B_47f8_A8E7_362220BEB016"
          },
          {
            klass: "Xmi::EaRoot::Citygml::ObjectType",
            attribute: "object_type",
            method: "base_class",
            value: "EAID_18E08BBD_DC0E_409a_AA6E_49C20958C49B"
          },
          {
            klass: "Xmi::EaRoot::Citygml::Union",
            attribute: "union",
            method: "base_data_type",
            value: "EAID_642E4231_E915_485f_94E6_A235CF1B5580"
          }
        ]

        citygml_test.each do |t|
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
