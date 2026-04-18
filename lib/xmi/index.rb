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

    PackagedElement = ::Xmi::Uml::PackagedElement

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
      freeze
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
      model = root.model
      if model
        id = model.id if model.respond_to?(:id)
        @id_name_map[id] = model.name if id && model.name
        walk_packaged_elements(model.packaged_element, nil)
      end

      ext = root.extension
      return unless ext

      index_extension_elements(ext.elements)
      index_extension_connectors(ext.connectors)

      primitives = ext.primitive_types
      walk_packaged_elements(primitives.packaged_element, nil) if primitives

      index_extension_profiles(ext.profiles)
    end

    def walk_packaged_elements(elements, parent) # rubocop:disable Metrics/MethodLength
      return unless elements

      id_name_map = @id_name_map
      packaged_by_id = @packaged_by_id
      packaged_by_type = @packaged_by_type
      upper_level_map = @upper_level_map
      packaged_elements = @packaged_elements
      owned_attrs_by_type = @owned_attrs_by_type_idref

      elements.each do |pe|
        next unless pe.is_a?(PackagedElement)

        pe_id = pe.id
        pe_type = pe.type
        pe_name = pe.name

        packaged_elements << pe
        packaged_by_id[pe_id] = pe if pe_id
        (packaged_by_type[pe_type] ||= []) << pe if pe_type
        upper_level_map[pe_id] = parent if parent && pe_id
        id_name_map[pe_id] = pe_name if pe_id && pe_name

        # Inline owned attribute indexing
        attrs = pe.owned_attribute
        if attrs && !attrs.empty?
          attrs.each do |oa|
            oa_id = oa.id
            id_name_map[oa_id] = oa.name if oa_id && oa.name
            oa_type = oa.uml_type
            if oa.association && oa_type && oa_type.idref
              (owned_attrs_by_type[oa_type.idref] ||= []) << oa
            end
          end
        end

        # Inline owned operation indexing
        ops = pe.owned_operation
        if ops && !ops.empty?
          ops.each do |oo|
            oo_id = oo.id
            id_name_map[oo_id] = oo.name if oo_id && oo.name
          end
        end

        # Inline owned literal indexing
        lits = pe.owned_literal
        if lits && !lits.empty?
          lits.each do |ol|
            ol_id = ol.id
            id_name_map[ol_id] = ol.name if ol_id && ol.name
          end
        end

        # Recurse into children
        walk_packaged_elements(pe.packaged_element, pe)
      end
    end

    def index_extension_elements(elements)
      return unless elements

      element_list = elements.element
      return unless element_list

      element_list.each do |e|
        idref = e.idref
        next unless idref

        @elements_by_idref[idref] = e

        props = e.properties
        @id_name_map[idref] = props.name if props&.name

        attrs_obj = e.attributes
        next unless attrs_obj

        attr_list = attrs_obj.attribute
        next unless attr_list

        attr_list.each do |a|
          @attributes_by_idref[a.idref] = a if a.idref
        end
      end
    end

    def index_extension_connectors(connectors)
      return unless connectors

      conn_list = connectors.connector
      return unless conn_list

      conn_list.each do |c|
        @connectors_by_idref[c.idref] = c if c.idref
      end
    end

    def index_extension_profiles(profiles)
      return unless profiles

      profile_list = profiles.profile
      return unless profile_list

      profile_list.each do |profile|
        walk_packaged_elements(profile.packaged_element, nil) if profile.respond_to?(:packaged_element)
      end
    end
  end
end
