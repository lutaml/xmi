# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Reference-holder models: small classes whose only job is to point
# at another element via xmi:idref or href.
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "UML reference holders" do
  describe Xmi::Uml::AnnotatedElement do
    it "inherits from Lutaml::Model::Serializable" do
      expect(described_class).to be < Lutaml::Model::Serializable
    end

    it "declares idref as XmiIdRef" do
      expect(described_class.attributes[:idref].type).to eq(Xmi::Type::XmiIdRef)
    end

    it "round-trips idref" do
      model = described_class.new(idref: "EAID_X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.idref).to eq("EAID_X1")
    end
  end

  describe Xmi::Uml::MemberEnd do
    it "declares idref as XmiIdRef" do
      expect(described_class.attributes[:idref].type).to eq(Xmi::Type::XmiIdRef)
    end

    it "round-trips idref" do
      model = described_class.new(idref: "EAID_A1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.idref).to eq("EAID_A1")
    end
  end

  describe Xmi::Uml::Type do
    it "declares idref as XmiIdRef" do
      expect(described_class.attributes[:idref].type).to eq(Xmi::Type::XmiIdRef)
    end

    it "declares href as :string" do
      expect(described_class.attributes[:href].type).to eq(Lutaml::Model::Type::String)
    end

    it "round-trips idref" do
      model = described_class.new(idref: "EAID_C1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.idref).to eq("EAID_C1")
    end

    it "round-trips href" do
      model = described_class.new(href: "http://example.com/types.xmi#Foo")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.href).to eq("http://example.com/types.xmi#Foo")
    end
  end
end

# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
