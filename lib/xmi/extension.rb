# frozen_string_literal: true

require "shale"

module Xmi
  class Extension < Shale::Mapper
    attribute :id, Shale::Type::Value
    attribute :label, Shale::Type::String
    attribute :uuid, Shale::Type::String
    attribute :href, Shale::Type::Value
    attribute :idref, Shale::Type::Value
    attribute :type, Shale::Type::Value
    attribute :extender, Shale::Type::String
    attribute :extender_id, Shale::Type::String

    xml do
      root "Extension"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmlns"

      map_attribute "id", to: :id, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "label", to: :label, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "uuid", to: :uuid, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "type", to: :type, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "extender", to: :extender
      map_attribute "extenderID", to: :extender_id
    end
  end

  # <model package2="EAID_C799E047_A10F_4203_9E22_9C47183CED98" package="EAPK_4C859105_86A2_46e7_8227_43951535FB4C" tpos="1" ea_localid="2" ea_eleType="package"/>
  class EaElementModel < Shale::Mapper
    attribute :package, Shale::Type::String
    attribute :package2, Shale::Type::String
    attribute :tops, Shale::Type::String
    attribute :ea_localid, Shale::Type::String
    attribute :ea_eleType, Shale::Type::String
  end

  # <properties isSpecification="false" sType="Class" nType="0" scope="public" stereotype="BasicDoc" isRoot="false" isLeaf="false" isAbstract="false" isActive="false"/>
  class EaElementProperties < Shale::Mapper
    attribute :is_specification, Shale::Type::Boolean
    attribute :is_root, Shale::Type::Boolean
    attribute :is_leaf, Shale::Type::Boolean
    attribute :is_abstract, Shale::Type::Boolean
    attribute :is_active, Shale::Type::Boolean
    attribute :s_type, Shale::Type::String
    attribute :n_type, Shale::Type::String
    attribute :scope, Shale::Type::String
    attribute :stereotype, Shale::Type::String

    xml do
      map_attribute 'isSpecification', to: :is_specification
      map_attribute 'isRoot', to: :is_root
      map_attribute 'isLeaf', to: :is_leaf
      map_attribute 'isAbstract', to: :is_abstract
      map_attribute 'isActive', to: :is_active
      map_attribute 'sType', to: :s_type
      map_attribute 'ntype', to: :n_type
      map_attribute 'scope', to: :scope
      map_attribute 'stereotype', to: :stereotype
    end
  end

  # <project author="LUKA" version="1.0" phase="1.0" created="2020-12-16 09:44:14" modified="2020-12-16 09:45:25" complexity="1" status="Proposed"/>
  class EaElementProject < Shale::Mapper
    attribute :author, Shale::Type::String
    attribute :version, Shale::Type::String
    attribute :phase, Shale::Type::String
    attribute :created, Shale::Type::Date
    attribute :modified, Shale::Type::Date
    attribute :complexity, Shale::Type::Integer
    attribute :status, Shale::Type::String
  end

  # <code gentype="&lt;none&gt;"/>
  # <code product_name="Java" gentype="Java"/>
  class EaElementCode < Shale::Mapper
    attribute :gentype, Shale::Type::String
    attribute :product_name, Shale::Type::String
  end

  # <style appearance="BackColor=-1;BorderColor=-1;BorderWidth=-1;FontColor=-1;VSwimLanes=1;HSwimLanes=1;BorderStyle=0;"/>
  class EaElementStyle < Shale::Mapper
    attribute :appearance, Shale::Type::String
  end

  class EaElementTags < Shale::Mapper
  end

  # <xrefs value="$XREFPROP=$XID={141F50DE-580C-4a82-AC5E-5BE2554B1671}$XID;$NAM=Stereotypes$NAM;$TYP=element property$TYP;$VIS=Public$VIS;$PAR=0$PAR;$DES=@STEREO;Name=Bibliography;@ENDSTEREO;$DES;$CLT={D832D6D8-0518-43f7-9166-7A4E3E8605AA}$CLT;$SUP=&lt;none&gt;$SUP;$ENDXREF;"/>
  class EaElementXrefs < Shale::Mapper
    attribute :value, Shale::Type::String
  end

  # <extendedProperties tagged="0" package_name="Model"/>
  class EaElementExtendedProperties < Shale::Mapper
    attribute :tagged, Shale::Type::String
    attribute :package_name, Shale::Type::String
  end

  # <packageproperties version="1.0" tpos="1"/>
  class EaElementPackageProperties < Shale::Mapper
    attribute :version, Shale::Type::String
    attribute :tpos, Shale::Type::String
  end

  class EaElementPath < Shale::Mapper
  end

  # <times created="2020-12-16 09:44:14" modified="2021-01-13 11:17:46" lastloaddate="2019-01-23 13:38:10" lastsavedate="2019-01-23 13:38:10"/>
  class EaElementTimes < Shale::Mapper
    attribute :created, Shale::Type::String
    attribute :modified, Shale::Type::String
    attribute :last_load_date, Shale::Type::String
    attribute :last_save_date, Shale::Type::String

    xml do
      map_attribute 'created', to: :created
      map_attribute 'modified', to: :modified
      map_attribute 'lastloaddate', to: :last_load_date
      map_attribute 'lastsavedate', to: :last_save_date
    end
  end

  # <flags iscontrolled="FALSE" isprotected="FALSE" batchsave="0" batchload="0" usedtd="FALSE" logxml="FALSE"/>
  class EaElementFlags < Shale::Mapper
    attribute :is_controlled, Shale::Type::Boolean
    attribute :is_protected, Shale::Type::Boolean
    attribute :batch_save, Shale::Type::Integer
    attribute :batch_load, Shale::Type::Integer
    attribute :used_td, Shale::Type::Boolean
    attribute :log_xml, Shale::Type::Boolean
    xml do
      map_attribute 'iscontrolled', to: :is_controlled
      map_attribute 'isprotected', to: :is_protected
      map_attribute 'batchsave', to: :batch_save
      map_attribute 'batchload', to: :batch_load
      map_attribute 'usedtd', to: :used_td
      map_attribute 'logxml', to: :log_xml
    end
  end

  class EaElementAssociation < Shale::Mapper
  end

  class EaElementAttributes < Shale::Mapper
  end

  # <links>
  #   <Association xmi:id="EAID_322379DE_61A8_411d_9638_5BB92DDF0A54" start="EAID_C1155D80_E68B_46d5_ADE5_F5639486163D" end="EAID_10AD8D60_9972_475a_AB7E_FA40212D5297"/>
  # </links>
  class EaElementLinks < Shale::Mapper
    attribute :associations, EaElementAssociation
  end


  # <element xmi:idref="EAPK_C799E047_A10F_4203_9E22_9C47183CED98" xmi:type="uml:Package" name="requirement type class diagram" scope="public">
  class EaElement < Shale::Mapper
    attribute :idref, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :name, Shale::Type::String
    attribute :scope, Shale::Type::String

    attribute :model, EaElementModel
    attribute :properties, EaElementProperties
    attribute :project, EaElementProject
    attribute :code, EaElementCode
    attribute :style, EaElementStyle
    attribute :tags, EaElementTags
    attribute :xrefs, EaElementXrefs
    attribute :extended_properties, EaElementExtendedProperties
    attribute :package_properties, EaElementPackageProperties
    attribute :paths, EaElementPath
    attribute :times, EaElementTimes
    attribute :flags, EaElementFlags
    attribute :links, EaElementLinks
    attribute :attributes, EaElementAttributes

    xml do
      root 'element'
      map_attribute "idref", to: :idref, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "type", to: :type, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute 'name', to: :name
      map_attribute 'scope', to: :scope

      map_element 'model', to: :model
      map_element 'properties', to: :properties
      map_element 'project', to: :project
      map_element 'code', to: :code
      map_element 'style', to: :style
      map_element 'tags', to: :tags
      map_element 'xrefs', to: :xrefs
      map_element 'extended_properties', to: :extended_properties
      map_element 'package_properties', to: :package_properties
      map_element 'paths', to: :paths
      map_element 'times', to: :times
      map_element 'flags', to: :flags
      end
  end

  class EaConnector < Shale::Mapper
  end

  class EaPrimitiveType < Shale::Mapper
  end

  class EaProfile < Shale::Mapper
  end

  class EaDiagram < Shale::Mapper
  end

  class EaExtension < Extension
    attribute :elements, EaElement, collection: true
    attribute :connectors, EaConnector, collection: true
    attribute :primitive_types, EaPrimitiveType, collection: true
    attribute :profiles, EaProfile, collection: true
    attribute :diagrams, EaDiagram, collection: true

    xml do
      root "Extension"
      namespace "http://www.omg.org/spec/XMI/20131001", "xmlns"

      map_attribute "id", to: :id, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "label", to: :label, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "uuid", to: :uuid, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "href", to: :href
      map_attribute "idref", to: :idref, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "type", to: :type, prefix: "xmlns", namespace: "http://www.omg.org/spec/XMI/20131001"
      map_attribute "elements", to: :elements
    end
  end
end
