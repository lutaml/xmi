# frozen_string_literal: true

module Xmi
  # Builds all commonly needed indexes from a parsed SparxRoot in a single
  # targeted walk, avoiding the generic map_id_name approach that visits every
  # attribute of every node.
  #
  # Indexes built:
  # - id_name_map: { xmi_id => name } for all nodes with both id and name
  # - packaged_elements: flat array of all PackagedElement instances
  # - packaged_by_id: { xmi_id => PackagedElement }
  # - packaged_by_type: { "uml:Class" => [...], "uml:Package" => [...], ... }
  # - upper_level_map: { xmi_id => parent PackagedElement }
  # - elements_by_idref: { idref => Extension::Element::Element }
  # - connectors_by_idref: { idref => Connector::Connector }
  # - attributes_by_idref: { idref => Extension::Element::Attribute }
  # - owned_attrs_by_type_idref: { type_idref => [OwnedAttribute, ...] }
  class Index
    attr_reader :id_name_map, :packaged_elements, :packaged_by_id,
                :packaged_by_type, :upper_level_map, :elements_by_idref,
                :connectors_by_idref, :attributes_by_idref,
                :owned_attrs_by_type_idref

    # @param root [Xmi::Sparx::SparxRoot] parsed XMI model
    def initialize(root)
      @id_name_map = {}
      @packaged_elements = []
      @packaged_by_id = {}
      @packaged_by_type = {}
      @upper_level_map = {}
      @elements_by_idref = {}
      @connectors_by_idref = {}
      @attributes_by_idref = {}
      @owned_attrs_by_type_idref = {}

      build(root)
    end

    # Lookup name by XMI ID
    # @param xmi_id [String] XMI identifier
    # @return [String, nil]
    def lookup_name(xmi_id)
      @id_name_map[xmi_id]
    end

    # Find packaged element by XMI ID
    # @param id [String]
    # @return [Xmi::Uml::PackagedElement, nil]
    def find_packaged_element(id)
      @packaged_by_id[id]
    end

    # Find parent of a packaged element
    # @param id [String] child XMI ID
    # @return [Xmi::Uml::PackagedElement, nil]
    def find_parent(id)
      @upper_level_map[id]
    end

    # Find extension element by idref
    # @param idref [String]
    # @return [Xmi::Sparx::Element::Element, nil]
    def find_element(idref)
      @elements_by_idref[idref]
    end

    # Find connector by idref
    # @param idref [String]
    # @return [Xmi::Sparx::Connector::Connector, nil]
    def find_connector(idref)
      @connectors_by_idref[idref]
    end

    # Find extension attribute by idref
    # @param idref [String]
    # @return [Xmi::Sparx::Element::Attribute, nil]
    def find_attribute(idref)
      @attributes_by_idref[idref]
    end

    # Find owned attributes whose uml_type.idref matches
    # @param type_idref [String]
    # @return [Array<Xmi::Uml::OwnedAttribute>]
    def find_owned_attrs_by_type(type_idref)
      @owned_attrs_by_type_idref[type_idref] || []
    end

    # Find packaged elements by UML type
    # @param type [String] e.g. "uml:Class", "uml:Package"
    # @return [Array<Xmi::Uml::PackagedElement>]
    def packaged_elements_of_type(type)
      @packaged_by_type[type] || []
    end

    # Find first packaged element by name and allowed types
    # @param name [String]
    # @param types [Array<String>] e.g. ["uml:Class", "uml:AssociationClass"]
    # @return [Xmi::Uml::PackagedElement, nil]
    def find_packaged_by_name_and_types(name, types)
      types.each do |type|
        elements = @packaged_by_type[type]
        next unless elements

        found = elements.find { |e| e.name == name }
        return found if found
      end
      nil
    end

    private

    def build(root)
      build_from_model(root)
      build_from_extension(root.extension) if root.extension
    end

    def build_from_model(root)
      model = root.model
      return unless model

      register_id_name(model)

      # Walk main model packaged elements
      walk_packaged_elements(model.packaged_element, nil)
    end

    def walk_packaged_elements(elements, parent)
      return unless elements

      elements.each do |pe|
        next unless pe.is_a?(::Xmi::Uml::PackagedElement)

        @packaged_elements << pe
        @packaged_by_id[pe.id] = pe if pe.id
        (@packaged_by_type[pe.type] ||= []) << pe if pe.type
        @upper_level_map[pe.id] = parent if parent && pe.id
        register_id_name(pe)

        index_owned_attributes(pe)
        index_owned_operations(pe)
        index_owned_literals(pe)

        # Recurse into children
        walk_packaged_elements(pe.packaged_element, pe)
      end
    end

    def index_owned_attributes(pe)
      return unless pe.owned_attribute

      pe.owned_attribute.each do |oa|
        register_id_name(oa)
        if oa.association && oa.uml_type && oa.uml_type.idref
          (@owned_attrs_by_type_idref[oa.uml_type.idref] ||= []) << oa
        end
      end
    end

    def index_owned_operations(pe)
      return unless pe.owned_operation

      pe.owned_operation.each { |oo| register_id_name(oo) }
    end

    def index_owned_literals(pe)
      return unless pe.owned_literal

      pe.owned_literal.each { |ol| register_id_name(ol) }
    end

    def build_from_extension(ext)
      # Index elements by idref
      elements = ext.elements
      index_extension_elements(elements) if elements

      # Index connectors by idref
      connectors = ext.connectors
      index_extension_connectors(connectors) if connectors

      # Walk primitive types and profiles packaged elements
      walk_packaged_elements(ext.primitive_types&.packaged_element, nil)
      profiles = ext.profiles
      index_extension_profiles(profiles) if profiles
    end

    def index_extension_elements(elements)
      return unless elements.respond_to?(:element)

      elements.element.each do |e|
        next unless e.idref

        @elements_by_idref[e.idref] = e

        # Register element name from properties
        if e.properties&.name
          @id_name_map[e.idref] = e.properties.name
        end

        # Index child attributes
        next unless e.attributes.respond_to?(:attribute)

        e.attributes.attribute.each do |a|
          @attributes_by_idref[a.idref] = a if a.idref
        end
      end
    end

    def index_extension_connectors(connectors)
      return unless connectors.respond_to?(:connector)

      connectors.connector.each do |c|
        @connectors_by_idref[c.idref] = c if c.idref
      end
    end

    def index_extension_profiles(profiles)
      return unless profiles.respond_to?(:profile)

      profiles.profile.each do |profile|
        if profile.respond_to?(:packaged_element)
          walk_packaged_elements(profile.packaged_element,
                                 nil)
        end
      end
    end

    def register_id_name(node)
      return unless node.respond_to?(:id) && node.respond_to?(:name)
      return unless node.id && node.name

      @id_name_map[node.id] = node.name
    end
  end
end
