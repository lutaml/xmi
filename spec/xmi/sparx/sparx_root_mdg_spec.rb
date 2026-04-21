# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::Root do # rubocop:disable Metrics/BlockLength
  describe ".parse_xml" do # rubocop:disable Metrics/BlockLength
    context "loading EA MDG extension on demand" do # rubocop:disable Metrics/BlockLength
      let(:xml_content) { cached_fixture("xmi-v2-4-2-default.xmi") }
      let(:mdg_definition_xml) { fixtures_path("ISO19103MDG v1.0.0-beta.xml") }
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
          Leaf
          Union
          CodeList
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
        it "does not contain Mdg module" do
          ea_modules = Xmi::EaRoot.constants.select do |c|
            Xmi::EaRoot.const_get(c).is_a?(Module) && c != :Gml && c != :Eauml
          end

          expect(ea_modules).to be_empty
        end
      end

      context "after loading extension" do # rubocop:disable Metrics/BlockLength
        before do
          Xmi::EaRoot.load_extension(mdg_definition_xml)
        end

        after do
          Xmi::EaRoot.unload_extension("Iso19103")
        end

        it "contains Mdg module" do
          ea_modules = Xmi::EaRoot.constants.select do |c|
            Xmi::EaRoot.const_get(c).is_a? Module
          end

          expect(ea_modules).not_to be_empty
        end

        it "creates Mdg classes dynamically" do
          mdg_klasses = Xmi::EaRoot::Iso19103.constants.select do |c|
            Xmi::EaRoot::Iso19103.const_get(c).is_a? Class
          end

          expect(mdg_klasses.sort).to eq(
            expected_mdg_klasses.map { |k|
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
          expected_mdg_klasses.each do |k|
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
          expected_mdg_klasses.each do |k|
            next if k == :GI_Element

            element_names = described_class
              .mappings_for(:xml).elements.map(&:name)

            expect(element_names).to include(k.to_s)
          end
        end

        mdg_test = [
          {
            klass: "Xmi::EaRoot::Iso19103::AbstractSchema",
            attribute: "abstract_schema",
            method: "base_package",
            value: "EAPK_63F21616_57B0_4ffc_A785_8FB5B49C27F1",
          },
          {
            klass: "Xmi::EaRoot::Iso19103::GIInterface",
            attribute: "gi_interface",
            method: "base_interface",
            value: "EAID_1EA35B7C_1E09_4fe5_B75D_515CA12171B9",
          },
          {
            klass: "Xmi::EaRoot::Iso19103::GIProperty",
            attribute: "gi_property",
            method: "base_property",
            value: "EAID_2A7400AC_F474_4063_A5B9_5C5305020D60",
          },
          {
            klass: "Xmi::EaRoot::Iso19103::GIEnumeration",
            attribute: "gi_enumeration",
            method: "base_enumeration",
            value: "EAID_5AC15946_7E2E_4d2e_8208_300138B764C9",
          },
          {
            klass: "Xmi::EaRoot::Iso19103::GIEnumerationLiteral",
            attribute: "gi_enumeration_literal",
            method: "base_enumeration_literal",
            value: "EAID_44EAA54D_A02D_4263_9EBF_C67721A40BAA",
          },
        ]

        mdg_test.each do |t|
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
