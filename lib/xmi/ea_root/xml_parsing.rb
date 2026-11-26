# frozen_string_literal: true

module Xmi
  class EaRoot
    module XmlParsing
      def get_abstract_klass_node(xmi_doc)
        xmi_doc.at_xpath(
          "//UMLProfiles//Stereotypes//Stereotype[@isAbstract='true']",
        )
      end

      def get_klass_name_from_node(node)
        return Lutaml::Model::Serializable.to_s unless node

        node.attributes.find { |a| a.name == "name" }.value
      end

      def get_module_name(xmi_doc)
        get_module_name_from_definition(xmi_doc).capitalize
      end

      def get_module_name_from_definition(xmi_doc)
        node = xmi_doc.at_xpath("//UMLProfile/Documentation")
        node.attributes.find { |a| a.name == "name" }&.value
      end

      def get_module_uri(xmi_doc)
        node = xmi_doc.at_xpath("//UMLProfile/Documentation")
        uri = node.attributes.find { |a| a.name == "URI" }&.value
        return uri if uri

        name = get_module_name_from_definition(xmi_doc)
        ver = node.attributes.find { |a| a.name == "version" }&.value

        "http://www.sparxsystems.com/profiles/#{name}/#{ver}"
      end

      def get_namespace_from_definition(xmi_doc)
        namespace_key = get_module_name_from_definition(xmi_doc)
        namespace_uri = get_module_uri(xmi_doc)

        { name: namespace_key, uri: namespace_uri }
      end

      def get_tag_name(tag)
        tag_name = tag.attributes.find { |a| a.name == "name" }.value
        tag_name == "xmlns" ? "altered_xmlns" : tag_name
      end
    end
  end
end
