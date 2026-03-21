# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::SparxRoot do # rubocop:disable Metrics/BlockLength
  describe ".parse_xml" do # rubocop:disable Metrics/BlockLength
    context "loading EA UML extension on demand" do # rubocop:disable Metrics/BlockLength
      let(:xml_content) { cached_fixture("xmi-v2-4-2-default-with-eauml.xmi") }
      let(:expected_eauml_klasses) do
        %i[
          Import
        ].sort
      end

      let(:expected_eauml_keys) do
        %i[
          import
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

      context "after loading extension" do
        it "contains Eauml module" do
          ea_modules = Xmi::EaRoot.constants.select do |c|
            Xmi::EaRoot.const_get(c).is_a? Module
          end

          expect(ea_modules).not_to be_empty
        end

        it "creates Eauml classes dynamically" do
          eauml_klasses = Xmi::Sparx::EaUml.constants.select do |c|
            Xmi::Sparx::EaUml.const_get(c).is_a? Class
          end

          expect(eauml_klasses.sort).to eq(
            expected_eauml_klasses.map { |k|
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
          expected_eauml_klasses.each do |k|
            expect(described_class.attributes).to have_key(Lutaml::Model::Utils.snake_case("eauml_#{k}").to_sym)
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
          expected_eauml_keys.each do |k|
            element_names = described_class
              .mappings_for(:xml).elements.map(&:name)

            expect(element_names).to include(k.to_s)
          end
        end

        eauml_test = [
          {
            klass: "Xmi::Sparx::EaUml::Import",
            attribute: "import",
            method: "base_package_import",
            value: "EAID_F70DFA0D_7146_4aed_B373_87BB8FD8FDC0",
          },
        ]

        eauml_test.each do |t|
          it "containses #{t[:klass]}" do
            eauml_method = :"eauml_#{t[:attribute]}"
            expect(xmi_root_model.send(eauml_method))
              .to be_instance_of(Array)
            expect(xmi_root_model.send(eauml_method).first.class.name)
              .to eq(t[:klass])
            expect(xmi_root_model.send(eauml_method).first
              .send(t[:method].to_sym)).to eq(t[:value])
          end
        end
      end
    end
  end
end
