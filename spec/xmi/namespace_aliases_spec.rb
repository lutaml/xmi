# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Xmi::Namespace::Omg Aliases" do
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
