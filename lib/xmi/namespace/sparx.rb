# frozen_string_literal: true

module Xmi
  module Namespace
    module Sparx
      # Namespace for EA Extension elements (inside <xmi:Extension>)
      # These are elements like <elements>, <connectors>, <diagrams>, etc.
      class Extension < Lutaml::Xml::Namespace
        uri "http://www.sparxsystems.com/extensions/ea"
        prefix_default "ea"
      end

      class SysPhS < Lutaml::Xml::Namespace
        uri "http://www.sparxsystems.com/profiles/SysPhS/1.0"
        prefix_default "sysphs"
      end

      class Gml < Lutaml::Xml::Namespace
        uri "http://www.sparxsystems.com/profiles/GML/1.0"
        prefix_default "GML"
      end

      class EaUml < Lutaml::Xml::Namespace
        uri "http://www.sparxsystems.com/profiles/EAUML/1.0"
        prefix_default "EAUML"
      end

      class CustomProfile < Lutaml::Xml::Namespace
        uri "http://www.sparxsystems.com/profiles/thecustomprofile/1.0"
        prefix_default "thecustomprofile"
      end

      class CityGml < Lutaml::Xml::Namespace
        uri "http://www.sparxsystems.com/profiles/CityGML/1.0"
        prefix_default "CityGML"
      end
    end
  end
end
