# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::EaRoot do
  describe ".load_extension" do
    context "with CityGML MDG" do
      let(:mdg_path) { fixtures_path("CityGML_MDG_Technology.xml") }

      after do
        described_class.unload_extension("Citygml") if described_class.extension_loaded?("Citygml")
      end

      it "creates module with correct name" do
        described_class.load_extension(mdg_path)
        expect(described_class.const_defined?(:Citygml)).to be true
      end

      it "creates expected classes" do
        described_class.load_extension(mdg_path)
        klasses = described_class::Citygml.constants.select do |c|
          described_class::Citygml.const_get(c).is_a?(Class)
        end
        expect(klasses).not_to be_empty
      end

      it "raises if loaded twice" do
        described_class.load_extension(mdg_path)
        expect do
          described_class.load_extension(mdg_path)
        end.to raise_error(ArgumentError)
      end
    end

    context "with ISO19103 MDG" do
      let(:mdg_path) { fixtures_path("ISO19103MDG v1.0.0-beta.xml") }

      after do
        described_class.unload_extension("Iso19103") if described_class.extension_loaded?("Iso19103")
      end

      it "creates module with correct name" do
        described_class.load_extension(mdg_path)
        expect(described_class.const_defined?(:Iso19103)).to be true
      end

      it "creates expected classes including abstract class" do
        described_class.load_extension(mdg_path)
        klasses = described_class::Iso19103.constants.select do |c|
          described_class::Iso19103.const_get(c).is_a?(Class)
        end
        expect(klasses).to include(:AbstractSchema, :GIClass, :GICodeSet)
      end

      it "non-abstract classes have root_tag" do
        described_class.load_extension(mdg_path)
        klass = described_class::Iso19103::AbstractSchema
        expect(klass.respond_to?(:root_tag)).to be true
      end

      it "registers extension as loaded" do
        described_class.load_extension(mdg_path)
        expect(described_class.extension_loaded?("Iso19103")).to be true
      end
    end
  end

  describe ".unload_extension" do
    it "removes the module" do
      mdg_path = fixtures_path("CityGML_MDG_Technology.xml")
      described_class.load_extension(mdg_path)
      described_class.unload_extension("Citygml")
      expect(described_class.const_defined?(:Citygml)).to be false
    end

    it "clears tracking" do
      mdg_path = fixtures_path("CityGML_MDG_Technology.xml")
      described_class.load_extension(mdg_path)
      described_class.unload_extension("Citygml")
      expect(described_class.extension_loaded?("Citygml")).to be false
    end
  end

  describe ".extension_loaded?" do
    it "returns false for unknown extension" do
      expect(described_class.extension_loaded?("NonExistent")).to be false
    end
  end
end
