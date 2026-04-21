# frozen_string_literal: true

module Xmi
  class EaRoot
    module ExtensionLifecycle
      def update_mappings(module_name)
        new_klasses = all_new_klasses(module_name)
        inject_model_attributes(new_klasses, module_name)
        inject_model_xml_mappings(new_klasses, module_name)
      end

      private

      def inject_model_attributes(new_klasses, module_name)
        sparx_root = Xmi::Sparx::Root
        new_klasses.each do |klass_name|
          method_name = Lutaml::Model::Utils.snake_case(klass_name)
          full_klass = EaRoot.const_get(module_name).const_get(klass_name)
          sparx_root.attribute method_name.to_sym, full_klass, collection: true
        end
      end

      def inject_model_xml_mappings(new_klasses, module_name)
        map_entries = []
        new_klasses.each do |klass_name|
          klass = EaRoot.const_get(module_name).const_get(klass_name)
          next unless klass.respond_to?(:root_tag)

          method_name = Lutaml::Model::Utils.snake_case(klass_name)
          map_entries << [klass.root_tag, method_name.to_sym]
        end

        return if map_entries.empty?

        Xmi::Sparx::Root.class_eval do
          xml do
            map_entries.each do |element_name, method_sym|
              map_element element_name, to: method_sym,
                                        value_map: Xmi::VALUE_MAP
            end
          end
        end
      end

      def all_new_klasses(module_name)
        EaRoot.const_get(module_name).constants.select do |c|
          EaRoot.const_get(module_name).const_get(c).is_a? Class
        end
      end
    end
  end
end
