# frozen_string_literal: true

require "spec_helper"
require "xmi"

# Direct contract specs for the two polymorphic dispatch maps.
# End-to-end parsing coverage lives in packaged_element_dispatch_spec
# and polymorphic_robustness_spec; these specs lock in the data-level
# contract so a refactor of the Hash-with-default cannot silently
# regress the fallback (only unknown-type parsing would break, which
# is exactly the case the fallback exists for).
#
# rubocop:disable-next RSpec/DescribeClass
RSpec.describe "polymorphic dispatch map contracts" do
  # Trigger autoload of the files that define both maps and their
  # associated base classes. Referencing the constant alone does not
  # trigger autoload because Ruby autoload is keyed on the constant
  # name being accessed, not on the file that defines it.
  Xmi::Uml::PackagedElement
  Xmi::Uml::ValueSpecification

  describe "PACKAGED_ELEMENT_POLYMORPHIC_MAP" do
    subject(:map) { Xmi::Uml::PACKAGED_ELEMENT_POLYMORPHIC_MAP }

    it "is frozen" do
      expect(map).to be_frozen
    end

    it "has a frozen class_map" do
      expect(map[:class_map]).to be_frozen
    end

    it "uses xmi:type as the discriminator" do
      expect(map[:attribute]).to eq("xmi:type")
    end

    it "falls back to PackagedElement for any unknown xmi:type" do
      expect(map[:class_map]["uml:TotallyFabricated"]).to eq("Xmi::Uml::PackagedElement")
    end

    it "falls back to PackagedElement for a nil discriminator" do
      expect(map[:class_map][nil]).to eq("Xmi::Uml::PackagedElement")
    end

    it "every declared value is a resolvable Xmi::Uml class" do
      map[:class_map].each_value do |class_name|
        expect(Object.const_get(class_name)).to be_a(Class)
      end
    end
  end

  describe "VALUE_SPECIFICATION_POLYMORPHIC_MAP" do
    subject(:map) { Xmi::Uml::VALUE_SPECIFICATION_POLYMORPHIC_MAP }

    it "is frozen" do
      expect(map).to be_frozen
    end

    it "has a frozen class_map" do
      expect(map[:class_map]).to be_frozen
    end

    it "uses xmi:type as the discriminator" do
      expect(map[:attribute]).to eq("xmi:type")
    end

    it "falls back to ValueSpecification for any unknown xmi:type" do
      expect(map[:class_map]["uml:TotallyFabricated"]).to eq("Xmi::Uml::ValueSpecification")
    end

    it "falls back to ValueSpecification for a nil discriminator" do
      expect(map[:class_map][nil]).to eq("Xmi::Uml::ValueSpecification")
    end

    it "every declared value is a resolvable Xmi::Uml class" do
      map[:class_map].each_value do |class_name|
        expect(Object.const_get(class_name)).to be_a(Class)
      end
    end
  end
end
