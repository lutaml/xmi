# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Package/Profile/Import family. These structural classes wire
# packaged_element/package_import collections.
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "Package, Profile, and Import classes" do
  describe Xmi::Uml::PackageImport do
    it "declares id as XmiId" do
      expect(described_class.attributes[:id].type).to eq(Xmi::Type::XmiId)
    end

    it "declares imported_package as ImportedPackage" do
      expect(described_class.attributes[:imported_package].type).to eq(Xmi::Uml::ImportedPackage)
    end

    it "round-trips id" do
      model = described_class.new(id: "X1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.id).to eq("X1")
    end
  end

  describe Xmi::Uml::ImportedPackage do
    it "declares href as :string" do
      expect(described_class.attributes[:href].type).to eq(Lutaml::Model::Type::String)
    end

    it "round-trips href" do
      model = described_class.new(href: "path/to/profile.xmi")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.href).to eq("path/to/profile.xmi")
    end
  end

  describe Xmi::Uml::ProfileApplication do
    it "declares applied_profile as ProfileApplicationAppliedProfile" do
      expect(described_class.attributes[:applied_profile].type)
        .to eq(Xmi::Uml::ProfileApplicationAppliedProfile)
    end
  end

  describe Xmi::Uml::ProfileApplicationAppliedProfile do
    it "declares href as :string" do
      expect(described_class.attributes[:href].type).to eq(Lutaml::Model::Type::String)
    end

    it "declares type as XmiType" do
      expect(described_class.attributes[:type].type).to eq(Xmi::Type::XmiType)
    end

    it "round-trips href" do
      model = described_class.new(href: "profile.xmi#foo", type: "uml:Profile")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.href).to eq("profile.xmi#foo")
    end
  end

  describe Xmi::Uml::Profile do
    it "inherits from Base (no longer uses ProfileAttributes concern)" do
      expect(described_class).to be < Xmi::Uml::Base
    end

    it "declares type via Base inheritance" do
      expect(described_class.attributes[:type].type).to eq(Xmi::Type::XmiType)
    end

    it "declares name and ns_prefix as :string" do
      attrs = described_class.attributes
      expect(attrs[:name].type).to eq(Lutaml::Model::Type::String)
      expect(attrs[:ns_prefix].type).to eq(Lutaml::Model::Type::String)
    end

    it "declares metamodel_reference as :string" do
      expect(described_class.attributes[:metamodel_reference].type)
        .to eq(Lutaml::Model::Type::String)
    end

    it "declares packaged_element and package_import as collections" do
      attrs = described_class.attributes
      expect(attrs[:packaged_element].type).to eq(Xmi::Uml::PackagedElement)
      expect(attrs[:packaged_element].collection?).to be(true)
      expect(attrs[:package_import].type).to eq(Xmi::Uml::PackageImport)
      expect(attrs[:package_import].collection?).to be(true)
    end

    it "round-trips name" do
      model = described_class.new(name: "MyProfile", id: "P1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.name).to eq("MyProfile")
    end
  end

  describe Xmi::Uml::AssociationGeneralization do
    it "inherits from Base" do
      expect(described_class).to be < Xmi::Uml::Base
    end

    it "declares general as :string" do
      expect(described_class.attributes[:general].type).to eq(Lutaml::Model::Type::String)
    end

    it "round-trips general reference" do
      model = described_class.new(general: "EAID_PARENT", id: "G1")
      reparsed = described_class.from_xml(model.to_xml)
      expect(reparsed.general).to eq("EAID_PARENT")
    end
  end
end

# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
