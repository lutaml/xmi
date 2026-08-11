# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::Index do
  describe "with ea-xmi-2.5.1.xmi" do
    let(:xml_content) { cached_fixture("ea-xmi-2.5.1.xmi") }
    let(:root) { Xmi::Sparx::Root.parse_xml(xml_content) }
    let(:index) { root.index }

    it "is frozen after construction" do
      expect(index).to be_frozen
    end

    describe "id_name_map" do
      it "contains known packaged element IDs" do
        expect(index.id_name_map).to be_a(Hash)
        expect(index.id_name_map).not_to be_empty

        expect(index.lookup_name("EAPK_C799E047_A10F_4203_9E22_9C47183CED98"))
          .to eq("requirement type class diagram")
      end

      it "returns nil for unknown IDs" do
        expect(index.lookup_name("nonexistent")).to be_nil
      end

      it "includes extension element names via idref" do
        # Extension elements have properties with names, indexed by idref
        expect(index.elements_by_idref).not_to be_empty
        some_idref = index.elements_by_idref.keys.first
        element = index.find_element(some_idref)
        expect(element).not_to be_nil
      end
    end

    describe "packaged elements" do
      it "has a non-empty flat list" do
        expect(index.packaged_elements).to be_an(Array)
        expect(index.packaged_elements).not_to be_empty
        expect(index.packaged_elements).to all(be_a(Xmi::Uml::PackagedElement))
      end

      it "indexes packaged elements by ID" do
        pe = index.find_packaged_element("EAPK_C799E047_A10F_4203_9E22_9C47183CED98")
        expect(pe).not_to be_nil
        expect(pe.name).to eq("requirement type class diagram")
      end

      it "returns nil for unknown packaged element ID" do
        expect(index.find_packaged_element("nonexistent")).to be_nil
      end

      it "groups packaged elements by type" do
        expect(index.packaged_by_type).to be_a(Hash)
        expect(index.packaged_by_type).not_to be_empty
        expect(index.packaged_elements_of_type("uml:Class")).to be_an(Array)
      end

      it "returns empty array for unknown type" do
        expect(index.packaged_elements_of_type("uml:NonExistent")).to eq([])
      end
    end

    describe "parent tracking" do
      it "tracks parent relationships" do
        expect(index.upper_level_map).to be_a(Hash)

        child_id = "EAID_D832D6D8_0518_43f7_9166_7A4E3E8605AA"
        parent = index.find_parent(child_id)
        expect(parent).not_to be_nil
        expect(parent.name).to eq("requirement type class diagram")
      end
    end

    describe "extension indexing" do
      it "indexes extension elements by idref" do
        expect(index.elements_by_idref).to be_a(Hash)
        expect(index.elements_by_idref).not_to be_empty
      end

      it "indexes connectors by idref" do
        expect(index.connectors_by_idref).to be_a(Hash)
        expect(index.connectors_by_idref).not_to be_empty

        conn = index.find_connector("EAID_2CA98919_831B_4182_BBC2_C2EAF17FEF60")
        expect(conn).not_to be_nil
      end

      it "returns nil for unknown connector" do
        expect(index.find_connector("nonexistent")).to be_nil
      end

      it "returns nil for unknown element" do
        expect(index.find_element("nonexistent")).to be_nil
      end

      it "returns nil for unknown attribute" do
        expect(index.find_attribute("nonexistent")).to be_nil
      end

      it "returns empty array for unknown type in owned attrs" do
        expect(index.find_owned_attrs_by_type("nonexistent")).to eq([])
      end
    end

    describe "#find_packaged_by_name_and_types" do
      it "finds a class by name" do
        result = index.find_packaged_by_name_and_types(
          "BibliographicItem", ["uml:Class"]
        )
        expect(result).not_to be_nil
        expect(result.name).to eq("BibliographicItem")
      end

      it "returns nil when name does not exist in any of the types" do
        result = index.find_packaged_by_name_and_types(
          "NonExistent", ["uml:Class", "uml:Package"]
        )
        expect(result).to be_nil
      end
    end
  end

  describe "with large_test.xmi (mixed namespaces + EAStubs)" do
    let(:xml_content) { cached_fixture("large_test.xmi") }
    let(:root) { Xmi::Sparx::Root.parse_xml(xml_content) }
    let(:index) { root.index }

    describe "EAStub indexing (commit b2593bd)" do
      it "indexes all EAStub names into id_name_map" do
        stubs = root.extension.ea_stub
        expect(stubs.length).to be >= 10

        stubs.each do |stub|
          next unless stub.id && stub.name

          expect(index.lookup_name(stub.id)).to eq(stub.name)
        end
      end

      it "indexes known EAStub by specific ID" do
        expect(index.lookup_name("EAID_5F1B0A70_92F5_42ef_9431_155EB96F7E5D"))
          .to eq("Date")
      end

      it "indexes CharacterString EAStub" do
        expect(index.lookup_name("EAID_0A614EA9_13B7_4ebe_85ED_AA187D27CBD1"))
          .to eq("CharacterString")
      end

      it "indexes Boolean EAStub" do
        expect(index.lookup_name("EAID_856E597C_0E32_427b_A9B4_FBAC45BFC002"))
          .to eq("Boolean")
      end

      it "EAStub names coexist with packaged element names in id_name_map" do
        expect(index.id_name_map).to be_a(Hash)
        expect(index.id_name_map.length).to be > root.extension.ea_stub.length
      end
    end

    it "builds packaged_by_type for mixed-version documents" do
      expect(index.packaged_by_type).not_to be_empty
    end
  end

  describe "with minimal XML (no extension)" do
    let(:xml) do
      <<~XML
        <?xml version="1.0"?>
        <xmi:XMI xmlns:xmi="http://www.omg.org/spec/XMI/20131001"
                 xmlns:uml="http://www.omg.org/spec/UML/20131001">
          <uml:Model xmi:type="uml:Model" name="Empty">
            <packagedElement xmi:type="uml:Package"
                             xmi:id="PKG_001" name="Pkg"/>
          </uml:Model>
        </xmi:XMI>
      XML
    end

    let(:root) { Xmi::Sparx::Root.parse_xml(xml) }
    let(:index) { root.index }

    it "indexes the model name" do
      expect(index.lookup_name("PKG_001")).to eq("Pkg")
    end

    it "has no extension elements" do
      expect(index.elements_by_idref).to be_empty
      expect(index.connectors_by_idref).to be_empty
      expect(index.attributes_by_idref).to be_empty
    end

    it "still indexes packaged elements" do
      expect(index.packaged_elements.length).to eq(1)
      expect(index.packaged_elements.first.name).to eq("Pkg")
    end
  end

  describe "with nested classifiers (minimal XML)" do
    let(:xml) do
      <<~XML
        <?xml version="1.0"?>
        <xmi:XMI xmlns:xmi="http://www.omg.org/spec/XMI/20131001"
                 xmlns:uml="http://www.omg.org/spec/UML/20131001">
          <uml:Model xmi:type="uml:Model" name="M">
            <packagedElement xmi:type="uml:Class"
                             xmi:id="CLS_OUTER" name="Outer">
              <nestedClassifier xmi:type="uml:Class"
                                xmi:id="CLS_INNER" name="Inner">
                <ownedAttribute xmi:type="uml:Property"
                                xmi:id="ATT_INNER" name="attr"/>
              </nestedClassifier>
            </packagedElement>
          </uml:Model>
        </xmi:XMI>
      XML
    end

    let(:root) { Xmi::Sparx::Root.parse_xml(xml) }
    let(:index) { root.index }

    it "indexes nested classifiers by ID" do
      expect(index.find_packaged_element("CLS_INNER")).not_to be_nil
    end

    it "indexes nested classifier names" do
      expect(index.lookup_name("CLS_INNER")).to eq("Inner")
    end

    it "tracks the owning class as parent" do
      expect(index.find_parent("CLS_INNER")&.id).to eq("CLS_OUTER")
    end

    it "includes nested classifiers in the type map" do
      ids = index.packaged_elements_of_type("uml:Class").map(&:id)
      expect(ids).to include("CLS_OUTER", "CLS_INNER")
    end

    it "indexes attributes owned by nested classifiers" do
      expect(index.lookup_name("ATT_INNER")).to eq("attr")
    end
  end
end
