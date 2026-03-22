# frozen_string_literal: true

require "spec_helper"

RSpec.describe "XMI Version Infrastructure" do
  before do
    Lutaml::Model::GlobalContext.reset!
    Xmi.init_versioning!
  end

  describe "VersionRegistry" do
    it "knows available versions" do
      expect(Xmi::VersionRegistry.available_versions).to contain_exactly(
        "20110701", "20131001", "20161101"
      )
    end

    it "returns version module for version string" do
      expect(Xmi::VersionRegistry.version_module("20131001")).to eq(Xmi::V20131001)
    end
  end

  describe "V20110701" do
    it "has correct register ID" do
      expect(Xmi::V20110701.register_id).to eq(:xmi_20110701)
    end

    it "binds to correct namespaces" do
      uris = Xmi::V20110701.register.bound_namespace_uris
      expect(uris).to include("http://www.omg.org/spec/XMI/20110701")
      expect(uris).to include("http://www.omg.org/spec/UML/20110701")
    end

    it "falls back to common" do
      expect(Xmi::V20110701.register.fallback).to include(:xmi_common)
    end

    it "has Extension model" do
      expect(Xmi::V20110701::Extension).to be_a(Class)
    end

    it "has Documentation model" do
      expect(Xmi::V20110701::Documentation).to be_a(Class)
    end
  end

  describe "V20131001" do
    it "has correct register ID" do
      expect(Xmi::V20131001.register_id).to eq(:xmi_20131001)
    end

    it "binds to correct namespaces" do
      uris = Xmi::V20131001.register.bound_namespace_uris
      expect(uris).to include("http://www.omg.org/spec/XMI/20131001")
      expect(uris).to include("http://www.omg.org/spec/UML/20131001")
    end

    it "falls back to V20110701" do
      expect(Xmi::V20131001.register.fallback).to include(:xmi_20110701)
    end

    it "has Documentation model" do
      expect(Xmi::V20131001::Documentation).to be_a(Class)
    end
  end

  describe "V20161101" do
    it "has correct register ID" do
      expect(Xmi::V20161101.register_id).to eq(:xmi_20161101)
    end

    it "binds to correct namespaces" do
      uris = Xmi::V20161101.register.bound_namespace_uris
      expect(uris).to include("http://www.omg.org/spec/XMI/20161101")
      expect(uris).to include("http://www.omg.org/spec/UML/20161101")
    end

    it "falls back to V20131001" do
      expect(Xmi::V20161101.register.fallback).to include(:xmi_20131001)
    end

    it "has Extension model" do
      expect(Xmi::V20161101::Extension).to be_a(Class)
    end
  end

  describe "Fallback chain resolution" do
    it "V20131001 falls back to V20110701 register" do
      expect(Xmi::V20131001.register.fallback).to include(:xmi_20110701)
    end

    it "V20161101 falls back to V20131001 register" do
      expect(Xmi::V20161101.register.fallback).to include(:xmi_20131001)
    end
  end

  describe "Xmi.init_versioning!" do
    it "can be called multiple times without error" do
      Xmi.init_versioning!
      Xmi.init_versioning!
      expect(Xmi.versioning_initialized?).to be true
    end

    it "marks versioning as initialized" do
      Xmi.init_versioning!
      expect(Xmi.versioning_initialized?).to be true
    end
  end

  describe "Versioned module" do
    it "provides xmi_namespace helper" do
      expect(Xmi::V20131001.xmi_namespace).to eq(Xmi::Namespace::Omg::Xmi20131001)
    end

    it "provides uml_namespace helper" do
      expect(Xmi::V20131001.uml_namespace).to eq(Xmi::Namespace::Omg::Uml20131001)
    end

    it "reports initialized status" do
      expect(Xmi::V20110701.initialized?).to be true
    end
  end

  describe "Xmi::Namespace::Omg Aliases" do
    describe "alias class URIs" do
      it "Xmi alias has correct URI matching Xmi20131001" do
        expect(Xmi::Namespace::Omg::Xmi.uri).to eq(Xmi::Namespace::Omg::Xmi20131001.uri)
        expect(Xmi::Namespace::Omg::Xmi.uri).to eq("http://www.omg.org/spec/XMI/20131001")
      end

      it "Uml alias has correct URI matching Uml20131001" do
        expect(Xmi::Namespace::Omg::Uml.uri).to eq(Xmi::Namespace::Omg::Uml20131001.uri)
        expect(Xmi::Namespace::Omg::Uml.uri).to eq("http://www.omg.org/spec/UML/20131001")
      end

      it "UmlDi alias has correct URI matching UmlDi20131001" do
        expect(Xmi::Namespace::Omg::UmlDi.uri).to eq(Xmi::Namespace::Omg::UmlDi20131001.uri)
        expect(Xmi::Namespace::Omg::UmlDi.uri).to eq("http://www.omg.org/spec/UML/20131001/UMLDI")
      end

      it "UmlDc alias has correct URI matching UmlDc20131001" do
        expect(Xmi::Namespace::Omg::UmlDc.uri).to eq(Xmi::Namespace::Omg::UmlDc20131001.uri)
        expect(Xmi::Namespace::Omg::UmlDc.uri).to eq("http://www.omg.org/spec/UML/20131001/UMLDC")
      end
    end

    describe "alias class prefixes" do
      it "Xmi alias has correct prefix" do
        expect(Xmi::Namespace::Omg::Xmi.prefix_default).to eq("xmi")
      end

      it "Uml alias has correct prefix" do
        expect(Xmi::Namespace::Omg::Uml.prefix_default).to eq("uml")
      end

      it "UmlDi alias has correct prefix" do
        expect(Xmi::Namespace::Omg::UmlDi.prefix_default).to eq("umldi")
      end

      it "UmlDc alias has correct prefix" do
        expect(Xmi::Namespace::Omg::UmlDc.prefix_default).to eq("dc")
      end
    end

    describe "namespace properties" do
      it "parent classes have correct URIs" do
        expect(Xmi::Namespace::Omg::Uml20131001.uri).to eq("http://www.omg.org/spec/UML/20131001")
        expect(Xmi::Namespace::Omg::Xmi20131001.uri).to eq("http://www.omg.org/spec/XMI/20131001")
        expect(Xmi::Namespace::Omg::UmlDi20131001.uri).to eq("http://www.omg.org/spec/UML/20131001/UMLDI")
        expect(Xmi::Namespace::Omg::UmlDc20131001.uri).to eq("http://www.omg.org/spec/UML/20131001/UMLDC")
      end

      it "parent classes have correct prefixes" do
        expect(Xmi::Namespace::Omg::Uml20131001.prefix_default).to eq("uml")
        expect(Xmi::Namespace::Omg::Xmi20131001.prefix_default).to eq("xmi")
        expect(Xmi::Namespace::Omg::UmlDi20131001.prefix_default).to eq("umldi")
        expect(Xmi::Namespace::Omg::UmlDc20131001.prefix_default).to eq("dc")
      end
    end

    describe "usage in models" do
      it "works in namespace declarations" do
        expect do
          Class.new(Lutaml::Model::Serializable) do
            xml do
              root "test"
              namespace Xmi::Namespace::Omg::Uml
            end
          end
        end.not_to raise_error
      end

      it "works in namespace_scope declarations" do
        expect do
          Class.new(Lutaml::Model::Serializable) do
            xml do
              root "test"
              namespace Xmi::Namespace::Omg::Xmi
              namespace_scope [
                Xmi::Namespace::Omg::Xmi,
                Xmi::Namespace::Omg::Uml,
                Xmi::Namespace::Omg::UmlDi,
              ]
            end
          end
        end.not_to raise_error
      end
    end
  end

  describe "Xmi::Parsing" do
    let(:xmi_21_xml) do
      <<~XML
        <?xml version="1.0"?>
        <xmi:XMI xmlns:xmi="http://www.omg.org/spec/XMI/20110701"
                 xmlns:uml="http://www.omg.org/spec/UML/20110701"
                 xmi:version="2.1">
          <xmi:Documentation>
            <xmi:contact>Test User</xmi:contact>
            <xmi:exporter>Test Exporter</xmi:exporter>
            <xmi:exporterVersion>1.0</xmi:exporterVersion>
          </xmi:Documentation>
        </xmi:XMI>
      XML
    end

    let(:xmi_25_xml) do
      <<~XML
        <?xml version="1.0"?>
        <xmi:XMI xmlns:xmi="http://www.omg.org/spec/XMI/20131001"
                 xmlns:uml="http://www.omg.org/spec/UML/20131001"
                 xmi:version="2.5.1">
          <xmi:Documentation>
            <xmi:contact>Test User</xmi:contact>
            <xmi:exporter>Test Exporter</xmi:exporter>
            <xmi:exporterVersion>2.0</xmi:exporterVersion>
            <xmi:exporterID>12345</xmi:exporterID>
            <xmi:timestamp>2024-01-01</xmi:timestamp>
          </xmi:Documentation>
        </xmi:XMI>
      XML
    end

    let(:xmi_252_xml) do
      <<~XML
        <?xml version="1.0"?>
        <xmi:XMI xmlns:xmi="http://www.omg.org/spec/XMI/20161101"
                 xmlns:uml="http://www.omg.org/spec/UML/20161101"
                 xmi:version="2.5.2">
          <xmi:Documentation>
            <xmi:contact>Test User</xmi:contact>
            <xmi:exporter>Test Exporter</xmi:exporter>
            <xmi:exporterVersion>3.0</xmi:exporterVersion>
            <xmi:exporterID>67890</xmi:exporterID>
            <xmi:timestamp>2024-06-01</xmi:timestamp>
          </xmi:Documentation>
        </xmi:XMI>
      XML
    end

    describe ".detect_version" do
      it "detects XMI 2.1 (20110701)" do
        info = Xmi::Parsing.detect_version(xmi_21_xml)
        expect(info[:xmi_version]).to eq("20110701")
      end

      it "detects XMI 2.5.1 (20131001)" do
        info = Xmi::Parsing.detect_version(xmi_25_xml)
        expect(info[:xmi_version]).to eq("20131001")
      end

      it "detects XMI 2.5.2 (20161101)" do
        info = Xmi::Parsing.detect_version(xmi_252_xml)
        expect(info[:xmi_version]).to eq("20161101")
      end

      it "returns namespace URIs" do
        info = Xmi::Parsing.detect_version(xmi_25_xml)
        expect(info[:uris][:xmi]).to eq("http://www.omg.org/spec/XMI/20131001")
        expect(info[:uris][:uml]).to eq("http://www.omg.org/spec/UML/20131001")
      end

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

    describe ".supported_versions" do
      it "lists all supported versions" do
        expect(Xmi::Parsing.supported_versions).to contain_exactly(
          "20110701", "20131001", "20161101"
        )
      end
    end

    describe ".version_supported?" do
      it "returns true for supported versions" do
        expect(Xmi::Parsing.version_supported?("20131001")).to be true
        expect(Xmi::Parsing.version_supported?("20110701")).to be true
        expect(Xmi::Parsing.version_supported?("20161101")).to be true
      end

      it "returns false for unsupported versions" do
        expect(Xmi::Parsing.version_supported?("19990101")).to be false
      end
    end
  end
end
