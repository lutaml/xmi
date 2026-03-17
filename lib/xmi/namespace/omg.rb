# frozen_string_literal: true

module Xmi
  module Namespace
    module Omg
      class Xmi20110701 < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/XMI/20110701"
        prefix_default "xmi"
      end

      class Xmi20131001 < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/XMI/20131001"
        prefix_default "xmi"
      end

      class Xmi20161101 < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/XMI/20161101"
        prefix_default "xmi"
      end

      class Uml20110701 < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/UML/20110701"
        prefix_default "uml"
      end

      class Uml20131001 < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/UML/20131001"
        prefix_default "uml"
      end

      class Uml20161101 < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/UML/20161101"
        prefix_default "uml"
      end

      class UmlDi20131001 < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/UML/20131001/UMLDI"
        prefix_default "umldi"
      end

      class UmlDi20161101 < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/UML/20161101/UMLDI"
        prefix_default "umldi"
      end

      class UmlDc20131001 < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/UML/20131001/UMLDC"
        prefix_default "dc"
      end

      class UmlDc20161101 < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/UML/20161101/UMLDC"
        prefix_default "dc"
      end

      # Alias classes for version-agnostic reference
      # These inherit from 20131001 (the normalized version used after replace_xmlns)
      # NOTE: We need to explicitly set uri and prefix_default because Ruby class
      # instance variables are not inherited
      class Xmi < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/XMI/20131001"
        prefix_default "xmi"
      end

      class Uml < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/UML/20131001"
        prefix_default "uml"
      end

      class UmlDi < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/UML/20131001/UMLDI"
        prefix_default "umldi"
      end

      class UmlDc < Lutaml::Xml::Namespace
        uri "http://www.omg.org/spec/UML/20131001/UMLDC"
        prefix_default "dc"
      end
    end
  end
end
