# frozen_string_literal: true

module Xmi
  module Uml
    # Common base for concrete UML element classes.
    #
    # Each concrete UML class redeclares the same `xmi:type` discriminator,
    # `xmi:id`, and UML namespace boilerplate. Inheriting from `Base`
    # removes that duplication — subclasses declare only their unique
    # attributes and `root` element name.
    #
    # Verified via spike: lutaml-model inherits attribute declarations,
    # namespace, and map_attribute lines from the parent's `xml do` block.
    # Subclasses override `root` and add their own attributes/mappings.
    #
    # Classes that don't fit this pattern (reference holders like
    # AnnotatedElement/MemberEnd/Type, or UmlDi-namespaced elements like
    # Bounds/Waypoint/Diagram) stay direct from Serializable.
    class Base < Lutaml::Model::Serializable
      skip_reference_registration
      attribute :type, ::Xmi::Type::XmiType
      attribute :id, ::Xmi::Type::XmiId

      xml do
        namespace ::Xmi::Namespace::Omg::Uml

        map_attribute "type", to: :type
        map_attribute "id", to: :id
      end
    end
  end
end
