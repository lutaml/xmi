# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::SparxRoot do # rubocop:disable Metrics/BlockLength
  describe ".parse_xml" do # rubocop:disable Metrics/BlockLength
    context "loading EA CityGML extension on demand" do # rubocop:disable Metrics/BlockLength
      let(:xml_content) do
        cached_fixture("xmi-v2-4-2-default-with-citygml.xmi")
      end
      let(:citygml_definition_xml) do
        fixtures_path("CityGML_MDG_Technology.xml")
      end
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
        # In lutaml-model 0.8+, element mappings use the class's default namespace
        # when no explicit namespace is set. The type's namespace is resolved at
        # runtime during parsing, not stored on the mapping.
        %w[
          http://www.omg.org/spec/XMI/20131001:Documentation
          http://www.omg.org/spec/XMI/20131001:Model
          http://www.omg.org/spec/XMI/20131001:Extension
          http://www.omg.org/spec/XMI/20131001:publicationDate
          http://www.omg.org/spec/XMI/20131001:edition
          http://www.omg.org/spec/XMI/20131001:number
          http://www.omg.org/spec/XMI/20131001:yearVersion
          http://www.omg.org/spec/XMI/20131001:ModelicaParameter
        ]
      end

      let!(:xmi_root_model) { described_class.parse_xml(xml_content) }

      context "before loading extension" do
        it "does not contain Citygml module" do
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
          Xmi::EaRoot.unload_extension("Citygml")
        end

        it "contains Citygml module" do
          ea_modules = Xmi::EaRoot.constants.select do |c|
            Xmi::EaRoot.const_get(c).is_a? Module
          end

          expect(ea_modules).not_to be_empty
        end

        it "creates Citygml classes dynamically" do
          citygml_klasses = Xmi::EaRoot::Citygml.constants.select do |c|
            Xmi::EaRoot::Citygml.const_get(c).is_a? Class
          end

          expect(citygml_klasses.sort).to eq(
            expected_citygml_klasses.map { |k|
              Lutaml::Model::Utils.classify(k).to_sym
            },
          )
        end

        it "containses original attributes" do
          expect_orig_attributes.each do |k|
            expect(described_class.attributes).to have_key(Lutaml::Model::Utils.snake_case(k).to_sym)
          end
        end

        it "containses new attributes" do
          expected_citygml_klasses.each do |k|
            expect(described_class.attributes).to have_key(Lutaml::Model::Utils.snake_case(k).to_sym)
          end
        end

        it "containses original xml mapping" do
          expect_orig_xml_mapping.each do |element_key|
            mappings = described_class
              .mappings_for(:xml).elements.map do |e|
              ns = e.namespace || e.default_namespace
              "#{ns}:#{e.name}"
            end

            expect(mappings).to include(element_key)
          end
        end

        it "containses new xml mapping" do
          # In lutaml-model 0.8+, element mappings use the class's default namespace
          # Check that the element names exist in the mappings
          expected_citygml_keys.each do |k|
            element_names = described_class
              .mappings_for(:xml).elements.map(&:name)

            expect(element_names).to include(k.to_s)
          end
        end

        citygml_test = [
          {
            klass: "Xmi::EaRoot::Citygml::ApplicationSchema",
            attribute: "application_schema",
            method: "base_package",
            value: "EAPK_1C8607D1_2967_44ff_948A_2A9256D00A45",
          },
          {
            klass: "Xmi::EaRoot::Citygml::CodeList",
            attribute: "code_list",
            method: "base_class",
            value: "EAID_63F44B99_981E_41ba_8BF9_0B7231BD321A",
          },
          {
            klass: "Xmi::EaRoot::Citygml::Property",
            attribute: "property",
            method: "base_property",
            value: "EAID_08C9C0B1_5EF2_498b_9615_D83FFF295CE4",
          },
          {
            klass: "Xmi::EaRoot::Citygml::FeatureType",
            attribute: "feature_type",
            method: "base_class",
            value: "EAID_D8E4EAFC_9DAF_4cba_9169_984738657435",
          },
          {
            klass: "Xmi::EaRoot::Citygml::TopLevelFeatureType",
            attribute: "top_level_feature_type",
            method: "base_class",
            value: "EAID_645EA139_9F9D_4caf_90C3_3455836FA55B",
          },
          {
            klass: "Xmi::EaRoot::Citygml::DataType",
            attribute: "data_type",
            method: "base_data_type",
            value: "EAID_4661534F_B67D_46b5_BC56_CEED3792F85B",
          },
          {
            klass: "Xmi::EaRoot::Citygml::Version",
            attribute: "version",
            method: "base_property",
            value: "EAID_dst1B1F37_56A4_4908_B024_75F617AEE928",
          },
          {
            klass: "Xmi::EaRoot::Citygml::BasicType",
            attribute: "basic_type",
            method: "base_class",
            value: "EAID_055FE569_234B_47f8_A8E7_362220BEB016",
          },
          {
            klass: "Xmi::EaRoot::Citygml::ObjectType",
            attribute: "object_type",
            method: "base_class",
            value: "EAID_18E08BBD_DC0E_409a_AA6E_49C20958C49B",
          },
          {
            klass: "Xmi::EaRoot::Citygml::Union",
            attribute: "union",
            method: "base_data_type",
            value: "EAID_642E4231_E915_485f_94E6_A235CF1B5580",
          },
        ]

        citygml_test.each do |t|
          it "containses #{t[:klass]}" do
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
