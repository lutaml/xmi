# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::XmiIdentity do
  describe "Attributes module" do
    let(:test_class) do
      Class.new(Lutaml::Model::Serializable) do
        include Xmi::XmiIdentity::Attributes
      end
    end

    it "adds 6 identity attributes when included" do
      attrs = test_class.attributes
      expect(attrs.keys).to contain_exactly(:id, :label, :uuid, :href, :idref,
                                            :type)
    end

    it "declares correct types for XMI namespaced attributes" do
      attrs = test_class.attributes
      expect(attrs[:id].type).to eq(Xmi::Type::XmiId)
      expect(attrs[:idref].type).to eq(Xmi::Type::XmiIdRef)
      expect(attrs[:type].type).to eq(Xmi::Type::XmiType)
      expect(attrs[:label].type).to eq(Xmi::Type::XmiLabel)
      expect(attrs[:uuid].type).to eq(Xmi::Type::XmiUuid)
      expect(attrs[:href].type).to eq(Lutaml::Model::Type::String)
    end
  end

  describe ".apply_xml_mappings" do
    let(:test_class) do
      Class.new(Lutaml::Model::Serializable) do
        include Xmi::XmiIdentity::Attributes

        xml do
          root "test"
          Xmi::XmiIdentity.apply_xml_mappings(self)
        end
      end
    end

    it "adds 6 XML attribute mappings" do
      mapped_names = test_class.mappings_for(:xml).attributes.map(&:name)
      expect(mapped_names).to contain_exactly("id", "label", "uuid", "href",
                                              "idref", "type")
    end

    it "maps each attribute to the correct symbol" do
      test_class.mappings_for(:xml).attributes.each do |attr_map|
        expect(attr_map.to).to eq(attr_map.name.to_sym)
      end
    end
  end
end
