# frozen_string_literal: true

module Xmi
  module Sparx
    # <model package2="EAID_C799E047_A10F_4203_9E22_9C47183CED98" package="EAPK_4C859105_86A2_46e7_8227_43951535FB4C" tpos="1" ea_localid="2" ea_eleType="package"/>
    class SparxElementModel < Shale::Mapper
      attribute :package, Shale::Type::String
      attribute :package2, Shale::Type::String
      attribute :tpos, Shale::Type::Integer
      attribute :ea_localid, Shale::Type::String
      attribute :ea_eleType, Shale::Type::String

      xml do
        root "model"

        map_attribute "package", to: :package
        map_attribute "package2", to: :package2
        map_attribute "tpos", to: :tpos
        map_attribute "ea_localid", to: :ea_localid
        map_attribute "ea_eleType", to: :ea_eleType
      end
    end

    # <properties isSpecification="false" sType="Class" nType="0" scope="public" stereotype="BasicDoc" isRoot="false" isLeaf="false" isAbstract="false" isActive="false"/>
    class SparxElementProperties < Shale::Mapper
      attribute :name, Shale::Type::String
      attribute :type, Shale::Type::String
      attribute :is_specification, Shale::Type::Boolean
      attribute :is_root, Shale::Type::Boolean
      attribute :is_leaf, Shale::Type::Boolean
      attribute :is_abstract, Shale::Type::Boolean
      attribute :is_active, Shale::Type::Boolean
      attribute :s_type, Shale::Type::String
      attribute :n_type, Shale::Type::String
      attribute :scope, Shale::Type::String
      attribute :stereotype, Shale::Type::String
      attribute :alias, Shale::Type::String
      attribute :documentation, Shale::Type::String

      xml do
        root "properties"

        map_attribute "name", to: :name
        map_attribute "type", to: :type
        map_attribute "isSpecification", to: :is_specification
        map_attribute "isRoot", to: :is_root
        map_attribute "isLeaf", to: :is_leaf
        map_attribute "isAbstract", to: :is_abstract
        map_attribute "isActive", to: :is_active
        map_attribute "sType", to: :s_type
        map_attribute "nType", to: :n_type
        map_attribute "scope", to: :scope
        map_attribute "stereotype", to: :stereotype
        map_attribute "alias", to: :alias
        map_attribute "documentation", to: :documentation
      end
    end

    # <project author="LUKA" version="1.0" phase="1.0" created="2020-12-16 09:44:14" modified="2020-12-16 09:45:25" complexity="1" status="Proposed"/>
    class SparxElementProject < Shale::Mapper
      attribute :author, Shale::Type::String
      attribute :version, Shale::Type::String
      attribute :phase, Shale::Type::String
      attribute :created, Shale::Type::String
      attribute :modified, Shale::Type::String
      attribute :complexity, Shale::Type::Integer
      attribute :status, Shale::Type::String

      xml do
        root "project"

        map_attribute "author", to: :author
        map_attribute "version", to: :version
        map_attribute "phase", to: :phase
        map_attribute "created", to: :created
        map_attribute "modified", to: :modified
        map_attribute "complexity", to: :complexity
        map_attribute "status", to: :status
      end
    end

    # <code gentype="&lt;none&gt;"/>
    # <code product_name="Java" gentype="Java"/>
    class SparxElementCode < Shale::Mapper
      attribute :gentype, Shale::Type::String
      attribute :product_name, Shale::Type::String

      xml do
        root "code"

        map_attribute "gentype", to: :gentype
        map_attribute "product_name", to: :product_name
      end
    end

    # <style appearance="BackColor=-1;BorderColor=-1;BorderWidth=-1;FontColor=-1;VSwimLanes=1;HSwimLanes=1;BorderStyle=0;"/>
    class SparxElementStyle < Shale::Mapper
      attribute :appearance, Shale::Type::String

      xml do
        root "style"
        map_attribute "appearance", to: :appearance
      end
    end

    # <tag xmi:id="EAID_DA606969_8B1E_440d_BFF4_7EFF137F3C09" name="edition" value="2" modelElement="EAID_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB"/>
    class SparxElementTag < Shale::Mapper
      attribute :id, Shale::Type::String
      attribute :name, Shale::Type::String
      attribute :value, Shale::Type::String
      attribute :model_element, Shale::Type::String

      xml do
        root "tag"
        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "name", to: :name
        map_attribute "value", to: :value
        map_attribute "modelElement", to: :model_element
      end
    end

    class SparxElementTags < Shale::Mapper
      attribute :tags, SparxElementTag, collection: true
      xml do
        root "tags"
        map_element "tag", to: :tags
      end
    end

    # <xrefs value="$XREFPROP=$XID={141F50DE-580C-4a82-AC5E-5BE2554B1671}$XID;$NAM=Stereotypes$NAM;$TYP=element property$TYP;$VIS=Public$VIS;$PAR=0$PAR;$DES=@STEREO;Name=Bibliography;@ENDSTEREO;$DES;$CLT={D832D6D8-0518-43f7-9166-7A4E3E8605AA}$CLT;$SUP=&lt;none&gt;$SUP;$ENDXREF;"/>
    class SparxElementXrefs < Shale::Mapper
      attribute :value, Shale::Type::String

      xml do
        root "xrefs"
        map_attribute "value", to: :value
      end
    end

    # <extendedProperties tagged="0" package_name="Model"/>
    class SparxElementExtendedProperties < Shale::Mapper
      attribute :tagged, Shale::Type::String
      attribute :package_name, Shale::Type::String
      attribute :virtual_inheritance, Shale::Type::Integer
      xml do
        root "extendedProperties"
        map_attribute "tagged", to: :tagged
        map_attribute "package_name", to: :package_name
        map_attribute "virtualInheritance", to: :virtual_inheritance
      end
    end

    # <packageproperties version="1.0" tpos="1"/>
    class SparxElementPackageProperties < Shale::Mapper
      attribute :version, Shale::Type::String
      attribute :xmiver, Shale::Type::String
      attribute :tpos, Shale::Type::String
      xml do
        root "packagedproperties"
        map_attribute "version", to: :version
        map_attribute "xmiver", to: :xmiver
        map_attribute "tpos", to: :tpos
      end
    end

    class SparxElementPaths < Shale::Mapper
      attribute :xmlpath, Shale::Type::String

      xml do
        root "paths"
        map_attribute "xmlpath", to: :xmlpath
      end
    end

    # <times created="2020-12-16 09:44:14" modified="2021-01-13 11:17:46" lastloaddate="2019-01-23 13:38:10" lastsavedate="2019-01-23 13:38:10"/>
    class SparxElementTimes < Shale::Mapper
      attribute :created, Shale::Type::String
      attribute :modified, Shale::Type::String
      attribute :last_load_date, Shale::Type::String
      attribute :last_save_date, Shale::Type::String

      xml do
        root "times"
        map_attribute "created", to: :created
        map_attribute "modified", to: :modified
        map_attribute "lastloaddate", to: :last_load_date
        map_attribute "lastsavedate", to: :last_save_date
      end
    end

    # <flags iscontrolled="FALSE" isprotected="FALSE" batchsave="0" batchload="0" usedtd="FALSE" logxml="FALSE"/>
    class SparxElementFlags < Shale::Mapper
      attribute :is_controlled, Shale::Type::Integer
      attribute :is_protected, Shale::Type::Integer
      attribute :batch_save, Shale::Type::Integer
      attribute :batch_load, Shale::Type::Integer
      attribute :used_td, Shale::Type::Integer
      attribute :log_xml, Shale::Type::Integer
      attribute :package_flags, Shale::Type::String

      xml do
        root "flags"
        map_attribute "iscontrolled", to: :is_controlled
        map_attribute "isprotected", to: :is_protected
        map_attribute "batchsave", to: :batch_save
        map_attribute "batchload", to: :batch_load
        map_attribute "usedtd", to: :used_td
        map_attribute "logxml", to: :log_xml
        map_attribute "packageFlags", to: :package_flags
      end
    end

    class SparxElementAssociation < Shale::Mapper
      attribute :id, Shale::Type::String
      attribute :start, Shale::Type::String
      attribute :end, Shale::Type::String
      attribute :name, Shale::Type::String, default: -> { "Association" }

      xml do
        root "Association"
        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "start", to: :start
        map_attribute "end", to: :end
      end
    end

    class SparxElementGeneralization < SparxElementAssociation
      attribute :name, Shale::Type::String, default: -> { "Generalization" }

      xml do
        root "Generalization"
        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "start", to: :start
        map_attribute "end", to: :end
      end
    end

    class SparxElementAggregation < SparxElementAssociation
      attribute :name, Shale::Type::String, default: -> { "Aggregation" }

      xml do
        root "Aggregation"
        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "start", to: :start
        map_attribute "end", to: :end
      end
    end

    class SparxElementNoteLink < SparxElementAssociation
      attribute :name, Shale::Type::String, default: -> { "NoteLink" }

      xml do
        root "NoteLink"
        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "start", to: :start
        map_attribute "end", to: :end
      end
    end

    class SparxElementAttributes < Shale::Mapper
    end

    class SparxElementLinks < Shale::Mapper
      attribute :associations, SparxElementAssociation, collection: true
      xml do
        root "links"
        map_element "Association", to: :associations
      end
    end

    # <element xmi:idref="EAPK_C799E047_A10F_4203_9E22_9C47183CED98" xmi:type="uml:Package" name="requirement type class diagram" scope="public">
    class SparxElement < Shale::Mapper
      attribute :idref, Shale::Type::String
      attribute :type, Shale::Type::String
      attribute :name, Shale::Type::String
      attribute :scope, Shale::Type::String

      attribute :model, SparxElementModel
      attribute :properties, SparxElementProperties
      attribute :project, SparxElementProject
      attribute :code, SparxElementCode
      attribute :style, SparxElementStyle
      attribute :tags, SparxElementTags
      attribute :xrefs, SparxElementXrefs
      attribute :extended_properties, SparxElementExtendedProperties
      attribute :package_properties, SparxElementPackageProperties
      attribute :paths, SparxElementPaths
      attribute :times, SparxElementTimes
      attribute :flags, SparxElementFlags
      attribute :links, SparxElementLinks
      attribute :attributes, SparxElementAttributes

      xml do
        root "element"
        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "type", to: :type, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "name", to: :name
        map_attribute "scope", to: :scope

        map_element "model", to: :model
        map_element "properties", to: :properties
        map_element "project", to: :project
        map_element "code", to: :code
        map_element "style", to: :style
        map_element "tags", to: :tags
        map_element "xrefs", to: :xrefs
        map_element "extendedProperties", to: :extended_properties
        map_element "packageproperties", to: :package_properties
        map_element "paths", to: :paths
        map_element "times", to: :times
        map_element "flags", to: :flags
      end
    end

    # <elements>
    class SparxElements < Shale::Mapper
      attribute :element, SparxElement, collection: true

      xml do
        root "elements"
        map_element "element", to: :element
      end
    end

    # <connector xmi:idref="EAID_21FAA572_89A7_4d52_99FD_05B76DD348B2">
    # <source xmi:idref="EAID_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB">
    # <model ea_localid="23471" type="Package" name="ISO 6709 Edition 2"/>
    # <role visibility="Public"/>
    # <type aggregation="none"/>
    # <constraints/>
    # <modifiers isOrdered="false" isNavigable="false"/>
    # <style value="Owned=0;Navigable=Non-Navigable;"/>
    # <documentation/>
    # <xrefs/>
    # <tags/>
    # </source>
    # <target xmi:idref="EAID_8A7B787D_513E_4be9_B65A_4139FC1D63BE">
    # <model ea_localid="18393" type="Package" name="ISO 19111 Edition 3"/>
    # <role visibility="Public"/>
    # <type aggregation="none"/>
    # <constraints/>
    # <modifiers isOrdered="false" isNavigable="false"/>
    # <style value="Owned=0;Navigable=Navigable;"/>
    # <documentation/>
    # <xrefs/>
    # <tags/>
    # </target>
    # <model ea_localid="26444"/>
    # <properties ea_type="Dependency" direction="Source -&gt; Destination"/>
    # <documentation/>
    # <appearance linemode="3" linecolor="0" linewidth="0" seqno="0" headStyle="0" lineStyle="0"/>
    # <labels/>
    # <extendedProperties virtualInheritance="0"/>
    # <style/>
    # <xrefs/>
    # <tags/>
    # </connector>

    class SparxConnectorModel < Shale::Mapper
      attribute :ea_localid, Shale::Type::String
      attribute :type, Shale::Type::String
      attribute :name, Shale::Type::String
      xml do
        map_attribute "ea_localid", to: :ea_localid
        map_attribute "type", to: :type
        map_attribute "name", to: :name
      end
    end

    class SparxConnectorEndRole < Shale::Mapper
      attribute :visibility, Shale::Type::String
      xml do
        root "role"
        map_attribute :visibility, to: :visibility
      end
    end

    class SparxConnectorEndType < Shale::Mapper
      attribute :aggregation, Shale::Type::String
      xml do
        root "type"
        map_attribute :aggregation, to: :aggregation
      end
    end

    class SparxConnectorEndModifiers < Shale::Mapper
      attribute :is_ordered, Shale::Type::Boolean
      attribute :is_navigable, Shale::Type::Boolean
      xml do
        root "type"
        map_attribute "isOrdered", to: :is_ordered
        map_attribute "isNavigable", to: :is_navigable
      end
    end

    class SparxConnectorEndConstraints < Shale::Mapper
    end

    class SparxConnectorEndStyle < Shale::Mapper
      attribute :value, Shale::Type::String

      xml do
        root "style"
        map_attribute "value", to: :value
      end
    end

    module SparxConnectorEnd
      def self.included(klass)
        klass.class_eval do
          attribute :idref, Shale::Type::String
          attribute :model, SparxConnectorModel
          attribute :role, SparxConnectorEndRole
          attribute :type, SparxConnectorEndType
          attribute :constraints, SparxConnectorEndConstraints
          attribute :modifiers, SparxConnectorEndModifiers
          attribute :style, SparxConnectorEndStyle
          attribute :documentation, Shale::Type::String
          attribute :xrefs, SparxElementXrefs
          attribute :tags, SparxElementTags
        end
      end
    end

    class SparxConnectorSource < Shale::Mapper
      include SparxConnectorEnd

      xml do
        root "source"
        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

        map_element "model", to: :model, render_nil: true
        map_element "role", to: :role, render_nil: true
        map_element "type", to: :type, render_nil: true
        map_element "constraints", to: :constraints, render_nil: true
        map_element "modifiers", to: :modifiers, render_nil: true
        map_element "style", to: :style, render_nil: true
        map_element "documentation", to: :documentation, render_nil: true
        map_element "xrefs", to: :xrefs, render_nil: true
        map_element "tags", to: :tags, render_nil: true
      end
    end

    class SparxConnectorTarget < Shale::Mapper
      include SparxConnectorEnd

      xml do
        root "target"
        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

        map_element "model", to: :model, render_nil: true
        map_element "role", to: :role, render_nil: true
        map_element "type", to: :type, render_nil: true
        map_element "constraints", to: :constraints, render_nil: true
        map_element "modifiers", to: :modifiers, render_nil: true
        map_element "style", to: :style, render_nil: true
        map_element "documentation", to: :documentation, render_nil: true
        map_element "xrefs", to: :xrefs, render_nil: true
        map_element "tags", to: :tags, render_nil: true
      end
    end

    # <properties ea_type="Dependency" direction="Source -&gt; Destination"/>
    class SparxConnectorProperties < Shale::Mapper
      attribute :ea_type, Shale::Type::String
      attribute :direction, Shale::Type::String

      xml do
        root "properties"
        map_attribute :ea_type, to: :ea_type
        map_attribute :direction, to: :direction
      end
    end

    # <appearance linemode="3" linecolor="0" linewidth="0" seqno="0" headStyle="0" lineStyle="0"/>
    class SparxConnectorAppearance < Shale::Mapper
      attribute :linemode, Shale::Type::Integer
      attribute :linecolor, Shale::Type::Integer
      attribute :linewidth, Shale::Type::Integer
      attribute :seqno, Shale::Type::Integer
      attribute :headStyle, Shale::Type::Integer
      attribute :lineStyle, Shale::Type::Integer

      xml do
        root "appearance"
        map_attribute :linemode, to: :linemode
        map_attribute :linecolor, to: :linecolor
        map_attribute :linewidth, to: :linewidth
        map_attribute :seqno, to: :seqno
        map_attribute :headStyle, to: :headStyle
        map_attribute :lineStyle, to: :lineStyle
      end
    end

    class SparxConnector < Shale::Mapper
      attribute :idref, Shale::Type::String
      attribute :source, SparxConnectorSource
      attribute :target, SparxConnectorTarget

      attribute :source, SparxConnectorSource
      attribute :target, SparxConnectorTarget
      attribute :model, SparxConnectorModel
      attribute :properties, SparxConnectorProperties
      attribute :documentation, Shale::Type::String
      attribute :appearance, SparxConnectorAppearance
      attribute :labels, Shale::Type::String
      attribute :extended_properties, SparxElementExtendedProperties
      attribute :style, SparxElementStyle
      attribute :tags, SparxElementTags
      attribute :xrefs, SparxElementXrefs

      xml do
        root "element"
        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

        map_element "source", to: :source
        map_element "target", to: :target
        map_element "model", to: :model
        map_element "properties", to: :properties
        map_element "documentation", to: :documentation, render_nil: true
        map_element "appearance", to: :appearance
        map_element "labels", to: :labels, render_nil: true
        map_element "extendedProperties", to: :extended_properties
        map_element "style", to: :style, render_nil: true
        map_element "xrefs", to: :xrefs, render_nil: true
        map_element "tags", to: :tags, render_nil: true
      end
    end

    # <connectors>
    class SparxConnectors < Shale::Mapper
      attribute :connector, SparxConnector, collection: true
      xml do
        root "connectors"
        map_element "connector", to: :connector
      end
    end

    # <primitivetypes>
    #   <packagedElement xmi:type="uml:Package" xmi:id="EAPrimitiveTypesPackage" name="EA_PrimitiveTypes_Package"/>
    # </primitivetypes>

    class SparxPrimitiveTypes < Shale::Mapper
      attribute :packaged_element, Uml::PackagedElement, collection: true

      xml do
        root "primitivetypes"

        map_element "packagedElement", to: :packaged_element
      end
    end

    class SparxProfiles < Shale::Mapper
      attribute :profile, Uml::Profile, collection: true

      xml do
        root "profiles"
        map_element "Profile", to: :profile,
          namespace: "http://www.omg.org/spec/UML/20131001",
          prefix: "uml"

      end
    end

    # <diagrams>
    #   <diagram xmi:id="EAID_C4D531A8_EF26_4b23_AD1F_FD383AB9082E">
    #     <model package="EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB" localID="10065" owner="EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB"/>
    #     <properties name="Main" type="Logical"/>
    #     <project author="friisan" version="2022" created="2018-05-29 12:37:04" modified="2018-05-30 10:15:54"/>
    #     <style1 value="ShowPrivate=1;ShowProtected=1;ShowPublic=1;HideRelationships=0;Locked=0;Border=1;HighlightForeign=1;PackageContents=0;SequenceNotes=0;ScalePrintImage=1;PPgs.cx=1;PPgs.cy=1;DocSize.cx=1720;DocSize.cy=1000;ShowDetails=0;Orientation=P;Zoom=94;ShowTags=0;OpParams=1;VisibleAttributeDetail=0;ShowOpRetType=1;ShowIcons=1;CollabNums=1;HideProps=1;ShowReqs=0;ShowCons=0;PaperSize=1;HideParents=1;UseAlias=0;HideAtts=0;HideOps=0;HideStereo=0;HideElemStereo=0;ShowTests=0;ShowMaint=0;ConnectorNotation=UML 2.1;ExplicitNavigability=0;ShowShape=1;AllDockable=0;AdvancedElementProps=1;AdvancedFeatureProps=1;AdvancedConnectorProps=1;m_bElementClassifier=1;SPT=1;ShowNotes=0;SuppressBrackets=0;SuppConnectorLabels=0;PrintPageHeadFoot=0;ShowAsList=0;"/>
    #     <style2 value="SaveTag=48361D1F;ExcludeRTF=0;DocAll=0;HideQuals=0;AttPkg=1;ShowTests=0;ShowMaint=0;SuppressFOC=1;MatrixActive=0;SwimlanesActive=1;KanbanActive=0;MatrixLineWidth=1;MatrixLineClr=0;MatrixLocked=0;TConnectorNotation=UML 2.1;TExplicitNavigability=0;AdvancedElementProps=1;AdvancedFeatureProps=1;AdvancedConnectorProps=1;m_bElementClassifier=1;SPT=1;MDGDgm=;STBLDgm=;ShowNotes=0;VisibleAttributeDetail=0;ShowOpRetType=1;SuppressBrackets=0;SuppConnectorLabels=0;PrintPageHeadFoot=0;ShowAsList=0;SuppressedCompartments=;Theme=:119;"/>
    #     <swimlanes value="locked=false;orientation=0;width=0;inbar=false;names=false;color=0;bold=false;fcol=0;tcol=-1;ofCol=-1;ufCol=-1;hl=0;ufh=0;hh=0;cls=0;bw=0;hli=0;bro=0;SwimlaneFont=lfh:-10,lfw:0,lfi:0,lfu:0,lfs:0,lfface:Carlito,lfe:0,lfo:0,lfchar:1,lfop:0,lfcp:0,lfq:0,lfpf=0,lfWidth=0;"/>
    #     <matrixitems value="locked=false;matrixactive=false;swimlanesactive=true;kanbanactive=false;width=1;clrLine=0;"/>
    #     <extendedProperties/>
    #     <xrefs/>
    #     <elements>
    #       <element geometry="Left=312;Top=115;Right=427;Bottom=170;" subject="EAID_FB86C623_9125_4d6d_BE60_58B1C55534CE" seqno="1" style="DUID=2B20EDAD;"/>
    #     </elements>
    #   </diagram>
    # </diagrams>

    class SparxDiagramElement < Shale::Mapper
      attribute :geometry, Shale::Type::String
      attribute :subject, Shale::Type::String
      attribute :seqno, Shale::Type::Integer
      attribute :style, Shale::Type::String

      xml do
        root "element"
        map_attribute "geometry", to: :geometry
        map_attribute "subject", to: :subject
        map_attribute "seqno", to: :seqno
        map_attribute "style", to: :style
      end
    end

    class SparxDiagramElements < Shale::Mapper
      attribute :element, SparxDiagramElement, collection: true
      xml do
        root "elements"

        map_element "element", to: :element
      end
    end

    class SparxDiagramModel < Shale::Mapper
      attribute :package, Shale::Type::String
      attribute :local_id, Shale::Type::String
      attribute :owner, Shale::Type::String

      xml do
        root "model"

        map_attribute "package", to: :package
        map_attribute "localID", to: :local_id
        map_attribute "owner", to: :owner
      end
    end

    class SparxDiagramStyle < Shale::Mapper
      attribute :value, SparxDiagramElement

      xml do
        map_attribute "value", to: :value
      end
    end

    class SparxDiagram < Shale::Mapper
      attribute :id, Shale::Type::String
      attribute :model, SparxDiagramModel
      attribute :properties, SparxElementProperties
      attribute :project, SparxElementProject
      attribute :style1, SparxDiagramStyle
      attribute :style2, SparxDiagramStyle
      attribute :swimlanes, SparxDiagramStyle
      attribute :matrixitems, SparxDiagramStyle
      attribute :extendedProperties, SparxElementExtendedProperties
      attribute :xrefs, SparxElementXrefs
      attribute :elements, SparxDiagramElements

      xml do
        root "diagram"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_element "model", to: :model
        map_element "properties", to: :properties
        map_element "project", to: :project
        map_element "style1", to: :style1, render_nil: true
        map_element "style2", to: :style2, render_nil: true
        map_element "swimlanes", to: :swimlanes, render_nil: true
        map_element "matrixitems", to: :matrixitems, render_nil: true
        map_element "extendedProperties", to: :extended_properties, render_nil: true
        map_element "xrefs", to: :xrefs, render_nil: true
        map_element "elements", to: :elements
      end

    end

    class SparxDiagrams < Shale::Mapper
      attribute :diagram, SparxDiagram, collection: true

      xml do
        root "diagrams"
        map_element "diagram", to: :diagram
      end
    end


    class SparxExtension < Shale::Mapper
      attribute :id, Shale::Type::String
      attribute :label, Shale::Type::String
      attribute :uuid, Shale::Type::String
      attribute :href, Shale::Type::String
      attribute :idref, Shale::Type::String
      attribute :type, Shale::Type::String
      attribute :extender, Shale::Type::String
      attribute :extender_id, Shale::Type::String

      attribute :elements, SparxElements
      attribute :connectors, SparxConnectors
      attribute :primitive_types, SparxPrimitiveTypes
      attribute :profiles, SparxProfiles
      attribute :diagrams, SparxDiagrams

      xml do
        root "Extension"
        # namespace "http://www.omg.org/spec/XMI/20131001", "xmi"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "label", to: :label, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "uuid", to: :uuid, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "href", to: :href
        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "type", to: :type, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "extender", to: :extender
        map_attribute "extenderID", to: :extender_id

        map_element "elements", to: :elements
        map_element "connectors", to: :connectors
        map_element "primitivetypes", to: :primitive_types
        map_element "profiles", to: :profiles
        map_element "diagrams", to: :diagrams
      end
    end

    # <SysPhS:ModelicaParameter base_Package="EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB" name="Standard representation of geographic point location by coordinates"/>
    class SparxSysPhS < Shale::Mapper
      attribute :base_package, Shale::Type::String
      attribute :name, Shale::Type::String

      xml do
        root "ModelicaParameter"
        namespace "http://www.sparxsystems.com/profiles/SysPhS/1.0", "SysPhS"
        map_attribute "base_Package", to: :base_package
        map_attribute "name", to: :name
      end
    end

    # <thecustomprofile:publicationDate base_Package="EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB" publicationDate="2022-09"/>
    class SparxCustomProfilePublicationDate < Shale::Mapper
      attribute :base_package, Shale::Type::String
      attribute :publication_date, Shale::Type::String

      xml do
        root "publicationDate"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"
        map_attribute "base_Package", to: :base_package
        map_attribute "publicationDate", to: :publication_date
      end
    end

    # <thecustomprofile:edition base_Package="EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB" edition="2"/>
    class SparxCustomProfileEdition < Shale::Mapper
      attribute :base_package, Shale::Type::String
      attribute :edition, Shale::Type::String

      xml do
        root "edition"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"
        map_attribute "base_Package", to: :base_package
        map_attribute "edition", to: :edition
      end
    end

    # <thecustomprofile:number base_Package="EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB" number="6709"/>
    class SparxCustomProfileNumber < Shale::Mapper
      attribute :base_package, Shale::Type::String
      attribute :number, Shale::Type::String

      xml do
        root "number"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"
        map_attribute "base_Package", to: :base_package
        map_attribute "number", to: :number
      end
    end

    # <thecustomprofile:yearVersion base_Package="EAPK_D235A1D4_1924_44ba_AA1E_0B0510AE9DCB" yearVersion="2022"/>
    class SparxCustomProfileYearVersion < Shale::Mapper
      attribute :base_package, Shale::Type::String
      attribute :year_version, Shale::Type::String

      xml do
        root "yearVersion"
        namespace "http://www.sparxsystems.com/profiles/thecustomprofile/1.0", "thecustomprofile"
        map_attribute "base_Package", to: :base_package
        map_attribute "yearVersion", to: :year_version
      end
    end

    class SparxRoot < Root
      attribute :extension, SparxExtension

      attribute :publication_date, SparxCustomProfilePublicationDate
      attribute :edition, SparxCustomProfileEdition
      attribute :number, SparxCustomProfileNumber
      attribute :year_version, SparxCustomProfileYearVersion
      attribute :modelica_parameter, SparxSysPhS

      xml do
        root "XMI"
        namespace "http://www.omg.org/spec/XMI/20131001", "xmi"

        map_attribute "id", to: :id, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "label", to: :label, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "uuid", to: :uuid, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "href", to: :href
        map_attribute "idref", to: :idref, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"
        map_attribute "type", to: :type, prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

        map_element "Documentation", to: :documentation,
                                     prefix: "xmi", namespace: "http://www.omg.org/spec/XMI/20131001"

        map_element "Model", to: :model,
                             namespace: "http://www.omg.org/spec/UML/20131001",
                             prefix: "uml"

        map_element "Extension", to: :extension,
                                 namespace: "http://www.omg.org/spec/XMI/20131001",
                                 prefix: "xmi"

        map_element "publicationDate", to: :publication_date,
                                       namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                                       prefix: "thecustomprofile"

        map_element "ModelicaParameter", to: :modelica_parameter,
                                         namespace: "http://www.sparxsystems.com/profiles/SysPhS/1.0",
                                         prefix: "SysPhS"

        map_element "edition", to: :edition,
                               namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                               prefix: "thecustomprofile"

        map_element "number", to: :number,
                              namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                              prefix: "thecustomprofile"

        map_element "yearVersion", to: :year_version,
                                   namespace: "http://www.sparxsystems.com/profiles/thecustomprofile/1.0",
                                   prefix: "thecustomprofile"
      end
    end

  end
end
