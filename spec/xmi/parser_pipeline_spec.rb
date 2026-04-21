# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::ParserPipeline do
  describe "Steps::FixEncoding" do
    it "fixes invalid UTF-8 encoding" do
      bad_xml = (+"test\xFF").force_encoding("UTF-8")
      result = described_class::Steps::FixEncoding.call(xml: bad_xml)
      expect(result[:xml].encoding.name).to eq("UTF-8")
    end

    it "passes through valid encoding unchanged" do
      good_xml = "<?xml version='1.0'?><test/>"
      result = described_class::Steps::FixEncoding.call(xml: good_xml)
      expect(result[:xml]).to eq(good_xml)
    end
  end

  describe "Steps::InitVersioning" do
    it "ensures versioning is initialized" do
      described_class::Steps::InitVersioning.call({})
      expect(Xmi.versioning_initialized?).to be true
    end
  end

  describe ".run" do
    it "executes all default steps and returns parsed root" do
      xml = cached_fixture("ea-xmi-2.5.1.xmi")
      result = described_class.run(
        { xml: xml, root_class: Xmi::Sparx::Root },
      )
      expect(result[:root]).to be_instance_of(Xmi::Sparx::Root)
    end

    it "builds the index" do
      xml = cached_fixture("ea-xmi-2.5.1.xmi")
      result = described_class.run(
        { xml: xml, root_class: Xmi::Sparx::Root },
      )
      expect(result[:root].index).to be_a(Xmi::Sparx::Index)
    end

    it "supports custom steps" do
      custom_step = Module.new do
        define_singleton_method(:call) { |ctx| ctx.merge(custom: true) }
      end
      result = described_class.run({ xml: "<test/>" }, steps: [custom_step])
      expect(result[:custom]).to be true
    end
  end
end
