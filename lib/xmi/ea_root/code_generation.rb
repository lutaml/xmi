# frozen_string_literal: true

module Xmi
  class EaRoot
    module CodeGeneration
      # Build extension classes directly via Class.new + const_set.
      def build_extension(xmi_doc)
        @module_name = get_module_name(xmi_doc)
        @def_namespace = get_namespace_from_definition(xmi_doc)

        # Resolve namespace class (returns class object)
        ns_class = resolve_namespace_class

        # Create the parent module Xmi::EaRoot::ModuleName
        mod = Module.new
        EaRoot.const_set(@module_name.to_sym, mod)

        # Process abstract class
        @abstract_klass_node = get_abstract_klass_node(xmi_doc)
        @abstract_tags = []
        abstract_klass = nil
        if @abstract_klass_node
          abstract_klass = build_abstract_class(mod, @abstract_klass_node)
        end

        # Process non-abstract stereotypes
        nodes = xmi_doc.xpath(
          "//UMLProfiles//Stereotypes//Stereotype[not(contains(@isAbstract, 'true'))]",
        )

        # Without baseStereotypes
        nodes.select { |n| n.attributes["baseStereotypes"].nil? }.each do |node|
          build_stereotype_class(mod, node, abstract_klass, ns_class)
        end

        # With baseStereotypes
        nodes.reject { |n| n.attributes["baseStereotypes"].nil? }.each do |node|
          base_name = node.attributes["baseStereotypes"].value
          build_stereotype_class(mod, node, abstract_klass, ns_class,
                                 parent_name: base_name)
        end
      end

      private

      def build_abstract_class(parent_mod, abstract_node)
        klass_name = Lutaml::Model::Utils.classify(
          get_klass_name_from_node(abstract_node),
        )

        klass = Class.new(Lutaml::Model::Serializable)

        # Add tag attributes (NO xml mapping for abstract classes)
        tags = abstract_node.search("Tag")
        @abstract_tags = tags
        tags.each do |tag|
          tag_name = get_tag_name(tag)
          attr_name = Lutaml::Model::Utils.snake_case(tag_name)
          klass.attribute attr_name.to_sym, :string
        end

        parent_mod.const_set(klass_name.to_sym, klass)
        klass
      end

      def build_stereotype_class(parent_mod, node, abstract_klass, ns_class,
                                 parent_name: nil)
        node_name = get_klass_name_from_node(node)
        klass_name = Lutaml::Model::Utils.classify(node_name)

        # Determine parent class
        parent_klass = if parent_name
                         parent_mod.const_get(Lutaml::Model::Utils.classify(parent_name).to_sym)
                       elsif abstract_klass
                         abstract_klass
                       else
                         Lutaml::Model::Serializable
                       end

        # Collect tags and apply types
        tags = node.search("Tag")
        apply_nodes = node.search("Apply")

        # Build the class
        klass = Class.new(parent_klass) do
          define_singleton_method(:root_tag) { node_name }
        end

        # Add tag attributes
        tags.each do |tag|
          tag_name = get_tag_name(tag)
          attr_name = Lutaml::Model::Utils.snake_case(tag_name)
          klass.attribute attr_name.to_sym, :string
        end

        # Add apply type attributes
        apply_nodes.each do |n|
          apply_types = n.attribute_nodes.map(&:value)
          apply_types.each do |apply_type|
            attr_name = Lutaml::Model::Utils.snake_case("base_#{apply_type}")
            klass.attribute attr_name.to_sym, :string
          end
        end

        # Add XML mapping
        # Pre-compute tag mapping pairs (xml block runs in Mapping context, not EaRoot)
        all_tag_pairs = (@abstract_tags + tags).map do |tag|
          tag_name = get_tag_name(tag)
          [tag_name, Lutaml::Model::Utils.snake_case(tag_name).to_sym]
        end

        apply_pairs = []
        apply_nodes.each do |n|
          n.attribute_nodes.map(&:value).each do |apply_type|
            apply_pairs << [
              "base_#{apply_type}",
              Lutaml::Model::Utils.snake_case("base_#{apply_type}").to_sym,
            ]
          end
        end

        klass.xml do
          root node_name
          namespace ns_class

          all_tag_pairs.each do |xml_name, attr_sym|
            map_attribute xml_name, to: attr_sym
          end

          apply_pairs.each do |xml_name, attr_sym|
            map_attribute xml_name, to: attr_sym
          end
        end

        parent_mod.const_set(klass_name.to_sym, klass)
        klass
      end
    end
  end
end
