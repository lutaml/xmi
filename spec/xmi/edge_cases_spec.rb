# frozen_string_literal: true

require "spec_helper"

RSpec.describe "XMI Version Edge Cases" do
  before(:all) { Xmi.init_versioning! }

  describe "Unknown namespaces" do
    let(:unknown_ns_xml) do
      <<~XML
        <?xml version="1.0"?>
        <xmi:XMI xmlns:xmi="http://www.omg.org/spec/XMI/20990101"
                 xmi:version="2.99">
          <xmi:Documentation>
            <xmi:contact>Test User</xmi:contact>
          </xmi:Documentation>
        </xmi:XMI>
      XML
    end

    it "handles unknown namespace gracefully with fallback" do
      # Should not raise - falls back to default parsing
      expect { Xmi.parse(unknown_ns_xml) }.not_to raise_error
    end

    it "detects unknown version" do
      info = Xmi::Parsing.detect_version(unknown_ns_xml)
      expect(info[:xmi_version]).to eq("20990101")
    end

    it "reports unknown version as unsupported" do
      expect(Xmi::Parsing.version_supported?("20990101")).to be false
    end
  end

  describe "No namespace" do
    let(:no_ns_xml) do
      <<~XML
        <?xml version="1.0"?>
        <XMI>
          <Documentation>
            <contact>Test User</contact>
          </Documentation>
        </XMI>
      XML
    end

    it "handles unnamespaced elements" do
      expect { Xmi.parse(no_ns_xml) }.not_to raise_error
    end

    it "returns nil for version detection" do
      info = Xmi::Parsing.detect_version(no_ns_xml)
      expect(info[:xmi_version]).to be_nil
    end
  end

  describe "Version detection" do
    it "detects UML version independently from XMI version" do
      xml = <<~XML
        <?xml version="1.0"?>
        <xmi:XMI xmlns:xmi="http://www.omg.org/spec/XMI/20110701"
                 xmlns:uml="http://www.omg.org/spec/UML/20131001">
        </xmi:XMI>
      XML

      info = Xmi::Parsing.detect_version(xml)
      expect(info[:versions][:xmi]).to eq("20110701")
      expect(info[:versions][:uml]).to eq("20131001")
    end

    it "handles empty document" do
      xml = '<?xml version="1.0"?><XMI></XMI>'
      info = Xmi::Parsing.detect_version(xml)
      expect(info[:xmi_version]).to be_nil
    end
  end

  describe "Error handling" do
    it "raises ArgumentError for unknown explicit version" do
      xml = '<xmi:XMI xmlns:xmi="http://www.omg.org/spec/XMI/20131001"/>'
      expect do
        Xmi.parse_with_version(xml, "19990101")
      end.to raise_error(ArgumentError, /Unknown version/)
    end
  end

  describe "Multiple version support" do
    it "lists all supported versions" do
      versions = Xmi::Parsing.supported_versions
      expect(versions).to contain_exactly("20110701", "20131001", "20161101")
    end

    it "supports all listed versions" do
      Xmi::Parsing.supported_versions.each do |version|
        expect(Xmi::Parsing.version_supported?(version)).to be true
      end
    end
  end

  describe "Initialization" do
    it "can be called multiple times" do
      Xmi.init_versioning!
      Xmi.init_versioning!
      expect(Xmi.versioning_initialized?).to be true
    end
  end
end
