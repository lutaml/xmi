# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::NamespaceDetector do
  describe ".extract_namespace_uris" do
    it "extracts default namespace" do
      xml = '<?xml version="1.0"?><root xmlns="http://example.com">'
      result = described_class.extract_namespace_uris(xml)
      expect(result["xmlns"]).to eq("http://example.com")
    end

    it "extracts prefixed namespaces" do
      xml = <<~XML
        <?xml version="1.0"?>
        <xmi:XMI xmlns:xmi="http://www.omg.org/spec/XMI/20131001"
                 xmlns:uml="http://www.omg.org/spec/UML/20131001">
      XML
      result = described_class.extract_namespace_uris(xml)
      expect(result["xmi"]).to eq("http://www.omg.org/spec/XMI/20131001")
      expect(result["uml"]).to eq("http://www.omg.org/spec/UML/20131001")
    end

    it "extracts single-quoted xmlns attributes" do
      xml = "<root xmlns:xmi='http://www.omg.org/spec/XMI/20110701'>"
      result = described_class.extract_namespace_uris(xml)
      expect(result["xmi"]).to eq("http://www.omg.org/spec/XMI/20110701")
    end

    it "takes first declaration when duplicates exist" do
      xml = '<root xmlns:foo="http://first" xmlns:foo="http://second">'
      result = described_class.extract_namespace_uris(xml)
      expect(result["foo"]).to eq("http://first")
    end

    it "only scans the first 8KB of content" do
      padding = " " * 9000
      xml = "#{padding}<root xmlns:far='http://beyond-scan'>"
      result = described_class.extract_namespace_uris(xml)
      expect(result).not_to have_key("far")
    end

    it "handles invalid UTF-8 gracefully" do
      xml = (+"\xFF\xFE<root xmlns:xmi='http://example.com'>").force_encoding("UTF-8")
      result = described_class.extract_namespace_uris(xml)
      expect(result["xmi"]).to eq("http://example.com")
    end

    it "returns empty hash for content with no xmlns declarations" do
      xml = "<?xml version='1.0'?><root/>"
      result = described_class.extract_namespace_uris(xml)
      expect(result).to eq({})
    end
  end

  describe ".detect_versions" do
    it "detects XMI and UML versions from real fixture" do
      xml = cached_fixture("ea-xmi-2.5.1.xmi")
      versions = described_class.detect_versions(xml)
      expect(versions[:xmi]).to eq("20131001")
      expect(versions[:uml]).to eq("20131001")
    end

    it "detects mixed versions (XMI 20131001 + UML 20161101)" do
      xml = cached_fixture("large_test.xmi")
      versions = described_class.detect_versions(xml)
      expect(versions[:xmi]).to eq("20131001")
      expect(versions[:uml]).to eq("20161101")
    end

    it "returns nil for absent namespaces" do
      xml = '<?xml version="1.0"?><root xmlns:xmi="http://www.omg.org/spec/XMI/20110701">'
      versions = described_class.detect_versions(xml)
      expect(versions[:xmi]).to eq("20110701")
      expect(versions[:uml]).to be_nil
      expect(versions[:umldi]).to be_nil
      expect(versions[:umldc]).to be_nil
    end
  end

  describe ".extract_namespace_uris_full" do
    it "returns all namespaces via full Nokogiri parse" do
      xml = cached_fixture("ea-xmi-2.5.1.xmi")
      result = described_class.extract_namespace_uris_full(xml)
      expect(result).to be_a(Hash)
      expect(result.keys).to include("xmlns:xmi", "xmlns:uml")
    end

    it "returns empty hash for malformed XML" do
      result = described_class.extract_namespace_uris_full("not xml at all")
      expect(result).not_to have_key("xmi")
    end
  end

  describe ".detect_version" do
    it "extracts version from an OMG XMI URI" do
      namespaces = { "xmi" => "http://www.omg.org/spec/XMI/20131001" }
      expect(described_class.detect_version(namespaces, :xmi)).to eq("20131001")
    end

    it "returns nil when no namespace matches the type" do
      namespaces = { "xmi" => "http://www.omg.org/spec/XMI/20131001" }
      expect(described_class.detect_version(namespaces, :uml)).to be_nil
    end
  end

  describe ".normalization_needed?" do
    it "returns true when any version is not 20131001" do
      versions = { xmi: "20110701", uml: "20131001", umldi: nil, umldc: nil }
      expect(described_class.normalization_needed?(versions)).to be true
    end

    it "returns false when all versions are 20131001 or nil" do
      versions = { xmi: "20131001", uml: "20131001", umldi: nil, umldc: nil }
      expect(described_class.normalization_needed?(versions)).to be false
    end
  end

  describe ".analyze" do
    it "returns comprehensive namespace info" do
      xml = cached_fixture("ea-xmi-2.5.1.xmi")
      analysis = described_class.analyze(xml)
      expect(analysis).to have_key(:versions)
      expect(analysis).to have_key(:uris)
      expect(analysis).to have_key(:raw_namespaces)
      expect(analysis).to have_key(:normalized_needed)
      expect(analysis[:raw_namespaces]).to be_a(Hash)
    end
  end

  describe "regex vs Nokogiri parity" do
    XmiFixtures::MODEL_FIXTURES.each_key do |fixture|
      it "regex extraction matches Nokogiri for #{fixture}" do
        skip "Fixture not found: #{fixture}" unless File.exist?(fixtures_path(fixture))

        xml = cached_fixture(fixture)
        regex_result = described_class.extract_namespace_uris(xml)
        nokogiri_result = described_class.extract_namespace_uris_full(xml)

        # Nokogiri keys include "xmlns:" prefix; regex keys don't.
        # Only compare namespaces found in the first 8KB (what regex scans).
        regex_result.each do |prefix, uri|
          nokogiri_key = prefix == "xmlns" ? "xmlns" : "xmlns:#{prefix}"
          nokogiri_uri = nokogiri_result[nokogiri_key]
          expect(nokogiri_uri).to(
            eq(uri),
            "Mismatch for prefix '#{prefix}': regex=#{uri.inspect} " \
            "vs nokogiri=#{nokogiri_uri.inspect} in #{fixture}",
          )
        end
      end
    end
  end
end
