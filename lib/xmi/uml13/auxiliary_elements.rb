# frozen_string_literal: true

require "shale"

require_relative "binding"
require_relative "comment"
require_relative "component"
require_relative "node"
require_relative "presentation"
require_relative "refinement"
require_relative "trace"
require_relative "usage"
require_relative "view_element"

class AuxiliaryElements < Shale::Mapper
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :refinement, Refinement, collection: true
  attribute :usage, Usage, collection: true
  attribute :trace, Trace, collection: true
  attribute :binding, Binding, collection: true
  attribute :node, Node, collection: true
  attribute :component, Component, collection: true
  attribute :comment, Comment, collection: true
  attribute :view_element, ViewElement, collection: true
  attribute :presentation, Presentation, collection: true

  xml do
    root "Auxiliary_Elements"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "xmi.id", to: :xmi_id
    map_attribute "xmi.label", to: :xmi_label
    map_attribute "xmi.uuid", to: :xmi_uuid
    map_attribute "href", to: :href
    map_attribute "xmi.idref", to: :xmi_idref
    map_element "Refinement", to: :refinement
    map_element "Usage", to: :usage
    map_element "Trace", to: :trace
    map_element "Binding", to: :binding
    map_element "Node", to: :node
    map_element "Component", to: :component
    map_element "Comment", to: :comment
    map_element "ViewElement", to: :view_element
    map_element "Presentation", to: :presentation
  end
end
