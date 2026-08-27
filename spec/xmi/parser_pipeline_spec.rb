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

  describe "Steps::ParseXml" do
    it "parses XML and sets :root in context" do
      xml = cached_fixture("ea-xmi-2.5.1.xmi")
      ctx = { xml: xml, root_class: Xmi::Sparx::Root }
      result = described_class::Steps::ParseXml.call(ctx)
      expect(result[:root]).to be_instance_of(Xmi::Sparx::Root)
    end
  end

  describe "Steps::BuildIndex" do
    it "builds index on Sparx::Root" do
      xml = cached_fixture("ea-xmi-2.5.1.xmi")
      root = Xmi::Sparx::Root.parse_xml(xml)
      ctx = { root: root }
      described_class::Steps::BuildIndex.call(ctx)
      expect(root.index).to be_a(Xmi::Sparx::Index)
    end

    it "works on base Root without error" do
      root = Xmi::Root.new
      ctx = { root: root }
      expect { described_class::Steps::BuildIndex.call(ctx) }.not_to raise_error
    end

    it "skips index building for models outside the Root hierarchy" do
      model = Xmi::Uml::UmlModel.new
      ctx = { root: model }
      expect { described_class::Steps::BuildIndex.call(ctx) }.not_to raise_error
    end
  end

  describe "every parse door repairs invalid UTF-8" do
    # The pipeline is the one deep module behind all public doors:
    # Xmi.parse, Xmi.parse_with_version, Xmi::Parsing.parse, and
    # Sparx::Root.parse_xml. Whichever door a consumer picks, the
    # encoding fix must have run.
    let(:bad_name) { (+"lab\xC3\x28").force_encoding(Encoding::UTF_8) }

    let(:xml) do
      <<~XML
        <xmi:XMI xmlns:xmi="http://www.omg.org/spec/XMI/20131001"
                 xmlns:uml="http://www.omg.org/spec/UML/20131001">
          <uml:Model xmi:type="uml:Model" xmi:id="EAID_M1" name="#{bad_name}"/>
        </xmi:XMI>
      XML
    end

    def assert_repaired(model)
      expect(model.name).to be_a(String)
      expect(model.name).to start_with("lab")
      expect([model.name.encoding, model.name.valid_encoding?])
        .to eq([Encoding::UTF_8, true])
    end

    it "Xmi.parse repairs invalid UTF-8" do
      assert_repaired(Xmi.parse(xml).model)
    end

    it "Xmi.parse_with_version repairs invalid UTF-8" do
      assert_repaired(Xmi.parse_with_version(xml, "20131001").model)
    end

    it "Xmi::Parsing.parse repairs invalid UTF-8" do
      assert_repaired(Xmi::Parsing.parse(xml).model)
    end

    it "Xmi::Parsing.parse with an explicit register repairs invalid UTF-8" do
      register = Xmi::VersionRegistry.register_for_version("20131001")
      assert_repaired(Xmi::Parsing.parse(xml, register: register).model)
    end

    it "Sparx::Root.parse_xml repairs invalid UTF-8" do
      assert_repaired(Xmi::Sparx::Root.parse_xml(xml).model)
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
        define_singleton_method(:call) do |ctx|
          ctx[:custom] = true
          ctx
        end
      end
      result = described_class.run({ xml: "<test/>" }, steps: [custom_step])
      expect(result[:custom]).to be true
    end

    it "mutates context hash without creating intermediates" do
      xml = cached_fixture("ea-xmi-2.5.1.xmi")
      original_ctx = { xml: xml, root_class: Xmi::Sparx::Root }
      result = described_class.run(original_ctx)
      expect(result).to equal(original_ctx)
    end
  end
end
