# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::Sparx::SparxRoot do # rubocop:disable Metrics/BlockLength
  context ".parse_xml" do # rubocop:disable Metrics/BlockLength
    context "when parsing from XML with XMI 2013 and UML 2016 (ISO 6709 Edition 2.xml)" do # rubocop:disable Metrics/BlockLength
      let(:xml) { File.new(fixtures_path("ISO 6709 Edition 2.xml")) }
      let(:xml_output) { xmi_root_model.to_xml }
      let(:xml_doc) { Nokogiri::XML(xml_output) }

      subject(:xmi_root_model) { described_class.parse_xml(File.read(xml)) }

      it { is_expected.to be_instance_of(Xmi::Sparx::SparxRoot) }

      it "should contains Documentation" do
        expect(xmi_root_model.documentation).to be_instance_of(Xmi::Documentation)
        expect(xmi_root_model.documentation.exporter).to eq("Enterprise Architect")
      end

      it "should contains Model" do
        expect(xmi_root_model.model).to be_instance_of(Xmi::Uml::UmlModel)
        expect(xmi_root_model.model.name).to eq("EA_Model")
        expect(xmi_root_model.model.packaged_element).to be_instance_of(Array)
        expect(xmi_root_model.model.packaged_element.first).to be_instance_of(Xmi::Uml::PackagedElement)
        expect(xmi_root_model.model.packaged_element.first.name).to eq("ISO 6709 Edition 2")
      end

      it "should contains Extension" do
        expect(xmi_root_model.extension).to be_instance_of(Xmi::Sparx::SparxExtension)
        expect(xmi_root_model.extension.extender).to eq("Enterprise Architect")
        expect(xmi_root_model.extension.profiles).to be_instance_of(Xmi::Sparx::SparxProfiles)
        expect(xmi_root_model.extension.profiles.profile).to be_instance_of(Array)
        expect(xmi_root_model.extension.profiles.profile.first).to be_instance_of(Xmi::Uml::Profile)
        expect(xmi_root_model.extension.profiles.profile.first.name).to eq("thecustomprofile")
      end

      context ".to_xml" do # rubocop:disable Metrics/BlockLength
        path_attr = [
          {
            path: "//xmi:Documentation"
          },
          {
            path: "//uml:Model",
            attr: {
              "xmi:type" => "uml:Model",
              "name" => "EA_Model"
            }
          },
          {
            path: "//uml:Model/packagedElement",
            attr: {
              "xmi:type" => "uml:Package",
              "xmi:id" => "EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB",
              "name" => "ISO 6709 Edition 2"
            }
          },
          {
            path: "//uml:Model/packagedElement/ownedComment",
            attr: {
              "xmi:type" => "uml:Comment",
              "xmi:id" => "EAID_FB86C623_9125_4d6d_BE60_58B1C55534CE",
              "body" => "No UML in this standard.&#xA;&#xA;Empty"
            }
          },
          {
            path: "//uml:Model/packagedElement/ownedComment/annotatedElement",
            attr: {
              "xmi:idref" => "EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB"
            }
          },
          {
            path: "//uml:Model/packagedElement/packagedElement",
            attr: {
              "xmi:type" => "uml:Dependency",
              "xmi:id" => "EAID_21FAA572_89A7_4d52_99FD_05B76DD348B2",
              "supplier" => "EAPK_8A7B787D_513E_4be9_B65A_4139FC1D63BE",
              "client" => "EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB"
            }
          },
          {
            path: "//uml:Model/umldi:Diagram",
            attr: {
              "xmi:type" => "umldi:UMLClassDiagram",
              "xmi:id" => "EAID_C4D531A8_EF26_4b23_AD1F_FD383AB9082E",
              "isFrame" => "false",
              "modelElement" => "EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB"
            }
          },
          {
            path: "//uml:Model/umldi:Diagram/ownedElement",
            attr: {
              "xmi:type" => "umldi:UMLShape",
              "xmi:id" => "EAID_C4D531A8_EF26_4b23_BE60_58B1C55534CE",
              "modelElement" => "EAID_FB86C623_9125_4d6d_BE60_58B1C55534CE"
            }
          },
          {
            path: "//uml:Model/umldi:Diagram/ownedElement/bounds",
            attr: {
              "xmi:type" => "dc:bounds",
              "xmi:id" => "EAID_DB000000_EF26_4b23_BE60_58B1C55534CE",
              "x" => "312",
              "y" => "115",
              "width" => "115",
              "height" => "55"
            }
          },
          {
            path: "//uml:Model/profileApplication",
            attr: {
              "xmi:type" => "uml:ProfileApplication",
              "xmi:id" => "profileap_thecustomprofile"
            }
          },
          {
            path: "//uml:Model/profileApplication/appliedProfile",
            attr: {
              "xmi:type" => "uml:Profile",
              "href" => "http://www.sparxsystems.com/profiles/thecustomprofile/1.0#thecustomprofile"
            }
          },
          {
            path: "//xmi:Extension",
            attr: {
              "extender" => "Enterprise Architect",
              "extenderID" => "6.5"
            }
          },
          {
            path: "//xmi:Extension/elements/element",
            attr: {
              "xmi:idref" => "EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB",
              "xmi:type" => "uml:Package",
              "name" => "ISO 6709 Edition 2",
              "scope" => "public"
            }
          },
          {
            path: "//xmi:Extension/elements/element/model",
            attr: {
              "package2" => "EAID_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB",
              "package" => "EAPK_44346D64_FF7D_40bb_B945_570B5E243B5C",
              "tpos" => "1",
              "ea_localid" => "2752",
              "ea_eleType" => "package"
            }
          },
          {
            path: "//xmi:Extension/elements/element/properties",
            attr: {
              "isSpecification" => "false",
              "sType" => "Package",
              "nType" => "0",
              "alias" => "Standard representation of geographic point location by coordinates",
              "scope" => "public"
            }
          },
          {
            path: "//xmi:Extension/elements/element/project",
            attr: {
              "author" => "knjetl",
              "version" => "2022",
              "phase" => "IS",
              "created" => "2018-05-29 12:37:04",
              "modified" => "2022-11-17 11:59:14",
              "complexity" => "2",
              "status" => "Approved"
            }
          },
          {
            path: "//xmi:Extension/elements/element/code",
            attr: {
              "gentype" => "Java"
            }
          },
          {
            path: "//xmi:Extension/elements/element/style",
            attr: {
              "appearance" => "BackColor=-1;BorderColor=-1;BorderWidth=-1;"\
                "FontColor=-1;VSwimLanes=1;HSwimLanes=1;BorderStyle=0;"
            }
          },
          {
            path: "//xmi:Extension/elements/element/tags/tag",
            attr: {
              "xmi:id" => "EAID_DA606969_8B1E_440d_BFF4_7EFF137F3C09",
              "name" => "edition",
              "value" => "2",
              "modelElement" => "EAID_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB"
            }
          },
          {
            path: "//xmi:Extension/elements/element/extendedProperties",
            attr: {
              "tagged" => "0",
              "package_name" => "ISO 6709 Standard representation of geographic point location by coordinates"
            }
          },
          {
            path: "//xmi:Extension/elements/element/packageproperties",
            attr: {
              "version" => "2022",
              "xmiver" => "Enterprise Architect XMI/UML 1.3",
              "tpos" => "1"
            }
          },
          {
            path: "//xmi:Extension/elements/element/paths",
            attr: {
              "xmlpath" => "ISO 6709 Edition 2.xml"
            }
          },
          {
            path: "//xmi:Extension/elements/element/times",
            attr: {
              "created" => "2018-05-29 12:37:04",
              "modified" => "2022-11-17 12:05:14",
              "lastloaddate" => "2018-06-03 13:24:40",
              "lastsavedate" => "2008-04-17 08:46:11"
            }
          },
          {
            path: "//xmi:Extension/elements/element/flags",
            attr: {
              "iscontrolled" => "0",
              "isprotected" => "0",
              "batchsave" => "1",
              "batchload" => "1",
              "usedtd" => "0",
              "logxml" => "0",
              "packageFlags" => "Recurse=1;"
            }
          },
          {
            path: "//xmi:Extension/elements/element/xrefs"
          },
          {
            path: "//xmi:Extension/connectors/connector/source/constraints"
          },
          {
            path: "//xmi:Extension/connectors/connector/source/documentation"
          },
          {
            path: "//xmi:Extension/connectors/connector/source/xrefs"
          },
          {
            path: "//xmi:Extension/connectors/connector/source/tags"
          },
          {
            path: "//xmi:Extension/connectors/connector/target/constraints"
          },
          {
            path: "//xmi:Extension/connectors/connector/target/documentation"
          },
          {
            path: "//xmi:Extension/connectors/connector/target/xrefs"
          },
          {
            path: "//xmi:Extension/connectors/connector/target/tags"
          },
          {
            path: "//xmi:Extension/connectors/connector/documentation"
          },
          {
            path: "//xmi:Extension/connectors/connector/labels"
          },
          {
            path: "//xmi:Extension/connectors/connector/style"
          },
          {
            path: "//xmi:Extension/connectors/connector/xrefs"
          },
          {
            path: "//xmi:Extension/connectors/connector/tags"
          },
          {
            path: "//xmi:Extension/connectors/connector",
            attr: {
              "xmi:idref" => "EAID_21FAA572_89A7_4d52_99FD_05B76DD348B2"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/source",
            attr: {
              "xmi:idref" => "EAID_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/source/model",
            attr: {
              "ea_localid" => "23471",
              "type" => "Package",
              "name" => "ISO 6709 Edition 2"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/source/role",
            attr: {
              "visibility" => "Public"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/source/type",
            attr: {
              "aggregation" => "none"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/source/modifiers",
            attr: {
              "isOrdered" => "false",
              "isNavigable" => "false"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/source/style",
            attr: {
              "value" => "Owned=0;Navigable=Non-Navigable;"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/target",
            attr: {
              "xmi:idref" => "EAID_8A7B787D_513E_4be9_B65A_4139FC1D63BE"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/target/model",
            attr: {
              "ea_localid" => "18393",
              "type" => "Package",
              "name" => "ISO 19111 Edition 3"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/target/role",
            attr: {
              "visibility" => "Public"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/target/type",
            attr: {
              "aggregation" => "none"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/target/modifiers",
            attr: {
              "isOrdered" => "false",
              "isNavigable" => "false"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/target/style",
            attr: {
              "value" => "Owned=0;Navigable=Navigable;"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/model",
            attr: {
              "ea_localid" => "26444"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/properties",
            attr: {
              "ea_type" => "Dependency",
              "direction" => "Source -&gt; Destination"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/appearance",
            attr: {
              "linemode" => "3",
              "linecolor" => "0",
              "linewidth" => "0",
              "seqno" => "0",
              "headStyle" => "0",
              "lineStyle" => "0"
            }
          },
          {
            path: "//xmi:Extension/connectors/connector/extendedProperties",
            attr: {
              "virtualInheritance" => "0"
            }
          },
          {
            path: "//xmi:Extension/primitivetypes"
          },
          {
            path: "//xmi:Extension/primitivetypes/packagedElement",
            attr: {
              "xmi:type" => "uml:Package",
              "xmi:id" => "EAPrimitiveTypesPackage",
              "name" => "EA_PrimitiveTypes_Package"
            }
          },
          {
            path: "//xmi:Extension/profiles/uml:Profile"
          },
          {
            path: "//xmi:Extension/profiles/uml:Profile",
            attr: {
              # "xmlns:uml" => "http://www.omg.org/spec/UML/20161101",
              # "xmlns:xmi" => "http://www.omg.org/spec/XMI/20161101",
              "xmi:id" => "thecustomprofile",
              "nsPrefix" => "thecustomprofile",
              "name" => "thecustomprofile",
              "metamodelReference" => "mmref01"
            }
          },
          {
            path: "//xmi:Extension/profiles/uml:Profile/ownedComment",
            attr: {
              "xmi:type" => "uml:Comment",
              "xmi:id" => "comment01",
              "annotatedElement" => "thecustomprofile"
            }
          },
          {
            path: "//xmi:Extension/profiles/uml:Profile/ownedComment/body",
            text: " Version:1.0"
          },
          {
            path: "//xmi:Extension/profiles/uml:Profile/packageImport",
            attr: {
              "xmi:id" => "mmref01"
            }
          },
          {
            path: "//xmi:Extension/profiles/uml:Profile/packageImport/importedPackage",
            attr: {
              "href" => "http://www.omg.org/spec/UML/20161101"
            }
          },
          {
            path: "//xmi:Extension/profiles/uml:Profile/packagedElement",
            attr: {
              "xmi:type" => "uml:Stereotype",
              "xmi:id" => "edition",
              "name" => "edition"
            }
          },
          {
            path: "//xmi:Extension/profiles/uml:Profile/packagedElement/ownedAttribute",
            attr: {
              "xmi:type" => "uml:Property",
              "xmi:id" => "edition-base_Package",
              "name" => "base_Package",
              "association" => "Package_edition"
            }
          },
          {
            path: "//xmi:Extension/profiles/uml:Profile/packagedElement/ownedAttribute/type",
            attr: {
              "href" => "http://www.omg.org/spec/UML/20161101/UML.xmi#Package"
            }
          },
          {
            path: "//xmi:Extension/profiles/uml:Profile/packagedElement/ownedEnd",
            attr: {
              "xmi:type" => "uml:ExtensionEnd",
              "xmi:id" => "extension_edition",
              "name" => "extension_edition",
              "type" => "edition",
              "isComposite" => "true",
              "lower" => "0",
              "upper" => "1",
              "memberEnd" => "extension_edition edition-base_Package"
            }
          },
          {
            path: "//diagrams/diagram",
            attr: {
              "xmi:id" => "EAID_C4D531A8_EF26_4b23_AD1F_FD383AB9082E"
            }
          },
          {
            path: "//diagrams/diagram/model",
            attr: {
              "package" => "EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB",
              "localID" => "10065",
              "owner" => "EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB"
            }
          },
          {
            path: "//diagrams/diagram/properties",
            attr: {
              "name" => "Main",
              "type" => "Logical"
            }
          },
          {
            path: "//diagrams/diagram/project",
            attr: {
              "author" => "friisan",
              "version" => "2022",
              "created" => "2018-05-29 12:37:04",
              "modified" => "2018-05-30 10:15:54"
            }
          },
          {
            path: "//diagrams/diagram/style1",
            attr: {
              "value" => "ShowPrivate=1;ShowProtected=1;ShowPublic=1;" \
              "HideRelationships=0;Locked=0;Border=1;HighlightForeign=1;" \
              "PackageContents=0;SequenceNotes=0;ScalePrintImage=1;" \
              "PPgs.cx=1;PPgs.cy=1;DocSize.cx=1720;DocSize.cy=1000;" \
              "ShowDetails=0;" \
              "Orientation=P;Zoom=94;ShowTags=0;OpParams=1;" \
              "VisibleAttributeDetail=0;ShowOpRetType=1;ShowIcons=1;" \
              "CollabNums=1;HideProps=1;ShowReqs=0;ShowCons=0;PaperSize=1;" \
              "HideParents=1;UseAlias=0;HideAtts=0;HideOps=0;HideStereo=0;" \
              "HideElemStereo=0;ShowTests=0;ShowMaint=0;ConnectorNotation=" \
              "UML 2.1;ExplicitNavigability=0;ShowShape=1;AllDockable=0;" \
              "AdvancedElementProps=1;AdvancedFeatureProps=1;" \
              "AdvancedConnectorProps=1;m_bElementClassifier=1;SPT=1;" \
              "ShowNotes=0;SuppressBrackets=0;SuppConnectorLabels=0;" \
              "PrintPageHeadFoot=0;ShowAsList=0;"
            }
          },
          {
            path: "//diagrams/diagram/style2",
            attr: {
              "value" => "SaveTag=48361D1F;ExcludeRTF=0;DocAll=0;HideQuals=0;" \
              "AttPkg=1;ShowTests=0;ShowMaint=0;SuppressFOC=1;MatrixActive=0;" \
              "SwimlanesActive=1;KanbanActive=0;MatrixLineWidth=1;" \
              "MatrixLineClr=0;MatrixLocked=0;TConnectorNotation=UML 2.1;" \
              "TExplicitNavigability=0;AdvancedElementProps=1;" \
              "AdvancedFeatureProps=1;AdvancedConnectorProps=1;" \
              "m_bElementClassifier=1;SPT=1;MDGDgm=;STBLDgm=;ShowNotes=0;" \
              "VisibleAttributeDetail=0;ShowOpRetType=1;SuppressBrackets=0;" \
              "SuppConnectorLabels=0;PrintPageHeadFoot=0;ShowAsList=0;" \
              "SuppressedCompartments=;Theme=:119;"
            }
          },
          {
            path: "//diagrams/diagram/swimlanes",
            attr: {
              "value" => "locked=false;orientation=0;width=0;inbar=false;" \
              "names=false;color=0;bold=false;fcol=0;tcol=-1;ofCol=-1;" \
              "ufCol=-1;hl=0;ufh=0;hh=0;cls=0;bw=0;hli=0;bro=0;" \
              "SwimlaneFont=lfh:-10,lfw:0,lfi:0,lfu:0,lfs:0,lfface:Carlito," \
              "lfe:0,lfo:0,lfchar:1,lfop:0,lfcp:0,lfq:0,lfpf=0,lfWidth=0;"
            }
          },
          {
            path: "//diagrams/diagram/matrixitems",
            attr: {
              "value" => "locked=false;matrixactive=false;swimlanesactive=" \
              "true;kanbanactive=false;width=1;clrLine=0;"
            }
          },
          {
            path: "//diagrams/diagram/extendedProperties"
          },
          {
            path: "//diagrams/diagram/xrefs"
          },
          {
            path: "//diagrams/diagram/elements/element",
            attr: {
              "geometry" => "Left=312;Top=115;Right=427;Bottom=170;",
              "subject" => "EAID_FB86C623_9125_4d6d_BE60_58B1C55534CE",
              "seqno" => "1",
              "style" => "DUID=2B20EDAD;"
            }
          },
          {
            path: "//thecustomprofile:publicationDate",
            attr: {
              "base_Package" => "EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB",
              "publicationDate" => "2022-09"
            }
          },
          {
            path: "//SysPhS:ModelicaParameter",
            attr: {
              "base_Package" => "EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB",
              "name" => "Standard representation of geographic point location by coordinates"
            }
          },
          {
            path: "//thecustomprofile:edition",
            attr: {
              "base_Package" => "EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB",
              "edition" => "2"
            }
          },
          {
            path: "//thecustomprofile:number",
            attr: {
              "base_Package" => "EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB",
              "number" => "6709"
            }
          },
          {
            path: "//thecustomprofile:yearVersion",
            attr: {
              "base_Package" => "EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB",
              "yearVersion" => "2022"
            }
          }
        ]

        it "should be able to output XML properly" do
          path_attr.each do |pa|
            expect(xml_output).to have_xpath(pa[:path])

            if pa[:attr]
              nodes = xml_doc.xpath(pa[:path]).first.attribute_nodes
              h = {}
              nodes.each do |a|
                name = a.namespace ? "#{a.namespace.prefix}:#{a.name}" : a.name
                h[name] = a.value
              end

              expect(h).to eq(
                pa[:attr].transform_values! { |v|
                  Nokogiri::XML.fragment(v).text
                }
              )
            end

            expect(xml_output).to have_xpath(pa[:path]).with_text(pa[:text]) if pa[:text]
          end
        end
      end
    end

    context "when parsing from XML with XMI 2013 and UML 2016 (large_test.xmi)" do
      let(:citygml_definition_xml) do
        File.new(fixtures_path("CityGML_MDG_Technology.xml"))
      end

      before do
        Xmi::EaRoot.load_extension(citygml_definition_xml)
      end

      after do
        Xmi::EaRoot.send(:remove_const, "Citygml")
      end

      let(:xml) { File.new(fixtures_path("large_test.xmi")) }
      let(:xml_output) { xmi_root_model.to_xml }

      subject(:xmi_root_model) { described_class.parse_xml(File.read(xml)) }

      it { is_expected.to be_instance_of(Xmi::Sparx::SparxRoot) }

      it "should contains EAStub in Extension" do
        expect(xmi_root_model.extension.ea_stub).to be_instance_of(Array)
        expect(xmi_root_model.extension.ea_stub.first).to be_instance_of(Xmi::Sparx::SparxEAStub)
        expect(xmi_root_model.extension.ea_stub.first.id).to eq("EAID_5F1B0A70_92F5_42ef_9431_155EB96F7E5D")
        expect(xmi_root_model.extension.ea_stub.first.name).to eq("Date")
        expect(xmi_root_model.extension.ea_stub.first.uml_type).to eq("Interface")
      end
    end
  end
end
