# frozen_string_literal: true

require "shale"

require_relative "association_end_role"
require_relative "association_role"
require_relative "classifier_role"
require_relative "collaboration"
require_relative "interaction"
require_relative "message"

class Collaborations < Shale::Mapper
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :collaboration, Collaboration, collection: true
  attribute :interaction, Interaction, collection: true
  attribute :association_role, AssociationRole, collection: true
  attribute :association_end_role, AssociationEndRole, collection: true
  attribute :message, Message, collection: true
  attribute :classifier_role, ClassifierRole, collection: true

  xml do
    root "Collaborations"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "xmi.id", to: :xmi_id
    map_attribute "xmi.label", to: :xmi_label
    map_attribute "xmi.uuid", to: :xmi_uuid
    map_attribute "href", to: :href
    map_attribute "xmi.idref", to: :xmi_idref
    map_element "Collaboration", to: :collaboration
    map_element "Interaction", to: :interaction
    map_element "AssociationRole", to: :association_role
    map_element "AssociationEndRole", to: :association_end_role
    map_element "Message", to: :message
    map_element "ClassifierRole", to: :classifier_role
  end
end
