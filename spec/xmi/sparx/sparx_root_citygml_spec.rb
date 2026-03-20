# frozen_string_literal: true

require "spec_helper"
require_relative "shared_contexts"

RSpec.describe Xmi::Sparx::SparxRoot do # rubocop:disable Metrics/BlockLength
  # Test CityGML extension loading across all three XMI fixture variants.
  # All three fixtures load the same CityGML class names and share structural
  # expectations (module presence, attribute registration, XML mappings).
  # Instance-level assertions only apply to fixtures that contain CityGML
  # elements (xmi-v2-4-2-default-with-citygml.xmi and full-242.xmi).
  [
    { xmi: "xmi-v2-4-2-default-with-citygml.xmi", has_elements: true },
    { xmi: "full-242.xmi",                        has_elements: true },
    { xmi: "xmi-v2-4-2-default.xmi",              has_elements: false },
  ].each do |variant|
    context "with #{variant[:xmi]}" do # rubocop:disable Metrics/BlockLength
      let(:xml_content) { cached_fixture(variant[:xmi]) }
      let(:citygml_definition_xml) { fixtures_path("CityGML_MDG_Technology.xml") }
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
            CityGmlShared::KLASSES.map { |k| Lutaml::Model::Utils.classify(k).to_sym }
          )
        end

        it "contains original attributes" do
          XmiExtensionShared::ORIG_ATTRIBUTES.each do |k|
            expect(Xmi::Sparx::SparxRoot.attributes).to have_key(Lutaml::Model::Utils.snake_case(k).to_sym)
          end
        end

        it "contains new attributes" do
          CityGmlShared::KLASSES.each do |k|
            expect(Xmi::Sparx::SparxRoot.attributes).to have_key(Lutaml::Model::Utils.snake_case(k).to_sym)
          end
        end

        it "contains original xml mapping" do
          XmiExtensionShared::ORIG_XML_MAPPING.each do |element_key|
            mappings = Xmi::Sparx::SparxRoot
                       .mappings_for(:xml).elements.map do |e|
              ns = e.namespace || e.default_namespace
              "#{ns}:#{e.name}"
            end

            expect(mappings).to include(element_key)
          end
        end

        it "contains new xml mapping" do
          CityGmlShared::KLASSES.each do |k|
            element_names = Xmi::Sparx::SparxRoot
                            .mappings_for(:xml).elements.map(&:name)

            expect(element_names).to include(k.to_s)
          end
        end

        # Instance-level tests only apply to fixtures with CityGML elements.
        next unless variant[:has_elements]

        CityGmlShared::INSTANCES.each do |attr, method, value|
          it "contains #{attr} with correct #{method}" do
            expect(xmi_root_model.send(attr.to_sym))
              .to be_instance_of(Array)
            expect(xmi_root_model.send(attr.to_sym).first.class.name)
              .to eq("Xmi::EaRoot::Citygml::#{Lutaml::Model::Utils.classify(attr)}")
            expect(xmi_root_model.send(attr.to_sym).first
              .send(method.to_sym)).to eq(value)
          end
        end
      end
    end
  end
end
