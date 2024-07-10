# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::SparxRoot2013 do # rubocop:disable Metrics/BlockLength
  context ".from_xml" do # rubocop:disable Metrics/BlockLength
    context "loading EA UML extension on demand" do # rubocop:disable Metrics/BlockLength
      let(:xml) { File.new(fixtures_path("xmi-v2-4-2-default-with-eauml.xmi")) }
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

      context "after loading extension" do # rubocop:disable Metrics/BlockLength
        it "should contain Eauml module" do
          ea_modules = Xmi::EaRoot.constants.select do |c|
            Xmi::EaRoot.const_get(c).is_a? Module
          end

          expect(ea_modules).not_to be_empty
        end

        it "should create Eauml classes dynamically" do
          eauml_klasses = Xmi::EaRoot::Eauml.constants.select do |c|
            Xmi::EaRoot::Eauml.const_get(c).is_a? Class
          end

          expect(eauml_klasses.sort).to eq(
            expected_eauml_klasses.map { |k| Shale::Utils.classify(k).to_sym }
          )
        end

        it "should contains original attributes" do
          expect_orig_attributes.each do |k|
            expect(Xmi::Sparx::SparxRoot2013.attributes).to have_key(Shale::Utils.snake_case(k).to_sym)
          end
        end

        it "should contains new attributes" do
          expected_eauml_klasses.each do |k|
            expect(Xmi::Sparx::SparxRoot2013.attributes).to have_key(Shale::Utils.snake_case("eauml_#{k}").to_sym)
          end
        end

        it "should contains original xml mapping" do
          expect_orig_xml_mapping.each do |element_key|
            expect(Xmi::Sparx::SparxRoot2013.xml_mapping.elements).to have_key(element_key)
          end
        end

        it "should contains new xml mapping" do
          expected_eauml_keys.each do |k|
            element_key = "http://www.sparxsystems.com/profiles/EAUML/1.0:#{k}"
            expect(Xmi::Sparx::SparxRoot2013.xml_mapping.elements).to have_key(element_key)
          end
        end

        eauml_test = [
          {
            klass: "Xmi::EaRoot::Eauml::Import",
            attribute: "import",
            method: "base_package_import",
            value: "EAID_F70DFA0D_7146_4aed_B373_87BB8FD8FDC0"
          }
        ]

        eauml_test.each do |t|
          it "should contains #{t[:klass]}" do
            eauml_method = "eauml_#{t[:attribute]}".to_sym
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
