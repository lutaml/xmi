# frozen_string_literal: true

require "shale"

require_relative "actor"
require_relative "use_case"
require_relative "use_case_instance"

class UseCases < Shale::Mapper
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :actor, Actor, collection: true
  attribute :use_case, UseCase, collection: true
  attribute :use_case_instance, UseCaseInstance, collection: true

  xml do
    root "Use_Cases"
    namespace "omg.org/UML1.3", "UML"

    map_attribute "xmi.id", to: :xmi_id
    map_attribute "xmi.label", to: :xmi_label
    map_attribute "xmi.uuid", to: :xmi_uuid
    map_attribute "href", to: :href
    map_attribute "xmi.idref", to: :xmi_idref
    map_element "Actor", to: :actor
    map_element "UseCase", to: :use_case
    map_element "UseCaseInstance", to: :use_case_instance
  end
end
