# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::Gml::HasBaseClass do
  it "adds base_class attribute when included" do
    klass = Class.new(Lutaml::Model::Serializable) do
      include Xmi::Sparx::Gml::HasBaseClass
    end
    expect(klass.attributes).to have_key(:base_class)
  end

  it "apply_xml_mappings adds map_attribute for base_Class" do
    klass = Class.new(Lutaml::Model::Serializable) do
      include Xmi::Sparx::Gml::HasBaseClass

      xml do
        root "test"
        Xmi::Sparx::Gml::HasBaseClass.apply_xml_mappings(self)
      end
    end
    attr_names = klass.mappings_for(:xml).attributes.map(&:name)
    expect(attr_names).to include("base_Class")
  end
end

RSpec.describe Xmi::Sparx::Gml::HasCollectionProperties do
  it "adds base_class, is_collection, and no_property_type attributes" do
    klass = Class.new(Lutaml::Model::Serializable) do
      include Xmi::Sparx::Gml::HasCollectionProperties
    end
    expect(klass.attributes).to have_key(:base_class)
    expect(klass.attributes).to have_key(:is_collection)
    expect(klass.attributes).to have_key(:no_property_type)
  end

  it "apply_xml_mappings adds all three map_attributes" do
    klass = Class.new(Lutaml::Model::Serializable) do
      include Xmi::Sparx::Gml::HasCollectionProperties

      xml do
        root "test"
        Xmi::Sparx::Gml::HasCollectionProperties.apply_xml_mappings(self)
      end
    end
    attr_names = klass.mappings_for(:xml).attributes.map(&:name)
    expect(attr_names).to include("base_Class", "isCollection",
                                  "noPropertyType")
  end
end
