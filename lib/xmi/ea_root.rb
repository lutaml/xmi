# frozen_string_literal: true

Dir[File.join(__dir__, "extensions", "*.rb")].each { |file| require file }

require "nokogiri"

module Xmi
  class EaRoot # rubocop:disable Metrics/ClassLength
    MODULE_TEMPLATE = <<~TEXT
      module Xmi
        class EaRoot
          module #MODULE_NAME#
      #KLASSES#
          end
        end
      end
    TEXT

    KLASS_TEMPLATE = <<~TEXT
            class #KLASS_NAME# < #FROM_KLASS#
              #ROOT_TAG_LINE#

      #ATTRIBUTES##XML_MAPPING#
            end
    TEXT

    XML_MAPPING = <<~TEXT
              xml do
                root "#ROOT_TAG#"
      #MAP_ATTRIBUTES#
              end
    TEXT

    ATTRIBUTE_LINE = <<~TEXT
      attribute :#TAG_NAME#, #ATTRIBUTE_TYPE#
    TEXT

    MAP_ATTRIBUTES = <<~TEXT
      map_attribute "#ATTRIBUTE_NAME#", to: :#ATTRIBUTE_METHOD#
    TEXT

    MAP_ELEMENT = <<~TEXT
      map_element "#ELEMENT_NAME#",
                  to: :#ELEMENT_METHOD#,
                  namespace: "#NAMESPACE#",
                  prefix: "#PREFIX#"
    TEXT

    class << self
      def load_extension(xml_path)
        @content = gen_content(xml_path)
        Object.class_eval @content
        update_mappings(@module_name)
      end

      def output_rb_file(output_rb_path)
        File.open(output_rb_path, "w") { |file| file.write(@content) }
      end

      private

      def update_mappings(module_name)
        new_klasses = all_new_klasses(module_name)
        map_elements = construct_shale_xml_mappings(new_klasses, module_name)
        sparx_roots.each do |sparx_root|
          update_shale_attributes(new_klasses, sparx_root, module_name)
          update_shale_xml_mappings(map_elements, sparx_root)
        end
      end

      def construct_shale_xml_mappings(new_klasses, module_name) # rubocop:disable Metrics/MethodLength
        map_elements = []
        new_klasses.each do |klass|
          next unless Xmi::EaRoot.const_get(module_name).const_get(klass)
                                 .respond_to? :root_tag

          map_elements << MAP_ELEMENT
                          .gsub("#ELEMENT_NAME#", Xmi::EaRoot.const_get(module_name).const_get(klass).root_tag)
                          .gsub("#ELEMENT_METHOD#", Shale::Utils.snake_case(klass.to_s))
                          .gsub("#NAMESPACE#", @def_namespace[:uri])
                          .gsub("#PREFIX#", @def_namespace[:name])
        end

        map_elements
      end

      def update_shale_attributes(new_klasses, sparx_root, module_name)
        new_klasses.each do |klass|
          method_name = Shale::Utils.snake_case(klass)
          full_klass_name = "Xmi::EaRoot::#{module_name}::#{klass}"
          attr_line = "#{ATTRIBUTE_LINE.rstrip}, collection: true"
          attr_line = attr_line
                      .gsub("#TAG_NAME#", method_name)
                      .gsub("#ATTRIBUTE_TYPE#", full_klass_name)

          sparx_root.class_eval(attr_line)
        end
      end

      def update_shale_xml_mappings(map_elements, sparx_root)
        new_mapping = sparx_root.class_variable_get("@@default_mapping")
        new_mapping += map_elements.join("\n")
        sparx_root.class_variable_set("@@mapping", new_mapping) # rubocop:disable Style/ClassVars

        new_mapping_block = proc do
          eval sparx_root.class_variable_get("@@mapping") # rubocop:disable Security/Eval
        end
        new_mapping = proc { xml(&new_mapping_block) }
        sparx_root.class_eval(&new_mapping)
      end

      def sparx_roots
        [Xmi::Sparx::SparxRoot, Xmi::Sparx::SparxRoot2013]
      end

      def all_new_klasses(module_name)
        Xmi::EaRoot.const_get(module_name).constants.select do |c|
          Xmi::EaRoot.const_get(module_name).const_get(c).is_a? Class
        end
      end

      def get_abstract_klass_node(xmi_doc)
        xmi_doc.at_xpath(
          "//UMLProfiles//Stereotypes//Stereotype[@isAbstract='true']"
        )
      end

      def get_klass_name_from_node(node)
        return Shale::Mapper.to_s unless node

        node.attribute_nodes.find { |attr| attr.name == "name" }.value
      end

      def gen_map_attribute_line(attr_name, attr_method)
        space_before = " " * 10
        method_name = Shale::Utils.snake_case(attr_method)

        map_attributes = MAP_ATTRIBUTES
                         .gsub("#ATTRIBUTE_NAME#", attr_name)
                         .gsub("#ATTRIBUTE_METHOD#", method_name)

        "#{space_before}#{map_attributes}"
      end

      def gen_attribute_line(tag_name, attribute_type = "Shale::Type::String")
        tag_name = Shale::Utils.snake_case(tag_name)
        space_before = " " * 8

        attribute_line = ATTRIBUTE_LINE
                         .gsub("#TAG_NAME#", tag_name)
                         .gsub("#ATTRIBUTE_TYPE#", attribute_type)

        "#{space_before}#{attribute_line}"
      end

      def get_tag_name(tag)
        tag.attribute_nodes.find { |attr| attr.name == "name" }.value
      end

      def gen_tags(node)
        tags = node.search("Tag")
        attributes_lines = ""

        tags.each do |tag|
          tag_name = get_tag_name(tag)
          attributes_lines += gen_attribute_line(tag_name)
        end

        [attributes_lines, tags]
      end

      def gen_abstract_klass # rubocop:disable Metrics/MethodLength
        unless @abstract_klass_node
          @abstract_tags = []
          return ""
        end

        attributes_lines = ""
        tags_lines, @abstract_tags = gen_tags(@abstract_klass_node)
        attributes_lines += tags_lines
        klass_name = get_klass_name_from_node(@abstract_klass_node)

        KLASS_TEMPLATE
          .gsub("#KLASS_NAME#", Shale::Utils.classify(klass_name))
          .gsub("#FROM_KLASS#", "Shale::Mapper")
          .gsub("#ATTRIBUTES#", attributes_lines.rstrip)
          .gsub("#XML_MAPPING#", "")
          .gsub("#ROOT_TAG_LINE#", "")
      end

      def gen_apply_types(node)
        apply_types_lines = ""
        apply_types_nodes = node.search("Apply")
        apply_types_nodes.each do |n|
          apply_types = n.attribute_nodes.map(&:value)
          apply_types.each do |apply_type|
            tag_name = "base_#{apply_type}"
            apply_types_lines += gen_attribute_line(tag_name)
          end
        end

        [apply_types_lines, apply_types_nodes]
      end

      def gen_generic_klass(node)
        node_name = get_klass_name_from_node(node)
        attributes_lines, map_attributes_lines = gen_klass_tags(node)
        apply_types_lines, apply_types_nodes = gen_apply_types(node)
        attributes_lines, map_attributes_lines = gen_klass_apply_types(
          attributes_lines, map_attributes_lines,
          apply_types_lines, apply_types_nodes
        )

        xml_mapping = replace_xml_mapping(node_name, map_attributes_lines)

        replace_klass_template(node_name, attributes_lines, xml_mapping)
      end

      def gen_klass_apply_types(attributes_lines, map_attributes_lines, apply_types_lines, apply_types_nodes)
        unless apply_types_nodes.empty?
          attributes_lines += apply_types_lines
          apply_types_nodes.each do |n|
            apply_types = n.attribute_nodes.map(&:value)
            apply_types.each do |apply_type|
              map_attributes_lines += gen_map_attribute_line("base_#{apply_type}", "base_#{apply_type}")
            end
          end
        end

        [attributes_lines, map_attributes_lines]
      end

      def gen_klass_tags(node)
        attributes_lines = ""
        map_attributes_lines = ""

        tags_lines, tags = gen_tags(node)
        attributes_lines += tags_lines
        (@abstract_tags + tags).each do |tag|
          tag_name = get_tag_name(tag)
          map_attributes_lines += gen_map_attribute_line(tag_name, tag_name)
        end

        [attributes_lines, map_attributes_lines]
      end

      def replace_xml_mapping(node_name, map_attributes_lines)
        XML_MAPPING
          .gsub("#ROOT_TAG#", node_name)
          .gsub("#MAP_ATTRIBUTES#", "\n#{map_attributes_lines.rstrip}")
          .rstrip
      end

      def replace_klass_template(node_name, attributes_lines, xml_mapping)
        abstract_klass_name = get_klass_name_from_node(@abstract_klass_node)
        root_tag_line = "def self.root_tag; \"#{node_name}\"; end"

        KLASS_TEMPLATE
          .gsub("#KLASS_NAME#", Shale::Utils.classify(node_name))
          .gsub("#FROM_KLASS#", Shale::Utils.classify(abstract_klass_name))
          .gsub("#ROOT_TAG_LINE#", root_tag_line)
          .gsub("#ATTRIBUTES#", attributes_lines.rstrip)
          .gsub("#XML_MAPPING#", "\n\n#{xml_mapping}")
      end

      def gen_generic_klasses(xmi_doc)
        nodes = xmi_doc.xpath("//UMLProfiles//Stereotypes//Stereotype[not(contains(@isAbstract, 'true'))]")
        klasses_lines = ""

        nodes.each do |node|
          klasses_lines += "#{gen_generic_klass(node)}\n"
        end

        klasses_lines
      end

      def gen_klasses(xmi_doc)
        @abstract_klass_node = get_abstract_klass_node(xmi_doc)
        klasses_lines = ""
        klasses_lines += "#{gen_abstract_klass}\n"
        klasses_lines += gen_generic_klasses(xmi_doc).rstrip
        klasses_lines
      end

      def gen_module(xmi_doc, module_name)
        MODULE_TEMPLATE
          .gsub("#MODULE_NAME#", module_name)
          .gsub("#KLASSES#", gen_klasses(xmi_doc))
      end

      def get_namespace_from_definition(xmi_doc)
        node = xmi_doc.at_xpath("//UMLProfile/Documentation")
        namespace_key = node.attribute_nodes.find do |attr|
          attr.name == "name"
        end.value
        namespace_uri = node.attribute_nodes.find do |attr|
          attr.name == "URI"
        end.value

        { name: namespace_key, uri: namespace_uri }
      end

      def gen_content(xml)
        xmi_doc = Nokogiri::XML(File.read(xml))
        @module_name = get_module_name(xmi_doc)
        @def_namespace = get_namespace_from_definition(xmi_doc)
        gen_module(xmi_doc, @module_name)
      end

      def get_module_name(xmi_doc)
        xmi_doc.root.name.split(".").first.capitalize
      end
    end
  end
end
