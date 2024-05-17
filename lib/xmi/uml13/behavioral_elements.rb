require 'shale'

require_relative 'collaborations'
require_relative 'common_behavior'
require_relative 'state_machines'
require_relative 'use_cases'

class BehavioralElements < Shale::Mapper
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :common_behavior, CommonBehavior, collection: true
  attribute :collaborations, Collaborations, collection: true
  attribute :use_cases, UseCases, collection: true
  attribute :state_machines, StateMachines, collection: true

  xml do
    root 'Behavioral_Elements'
    namespace 'omg.org/UML1.3', 'UML'

    map_attribute 'xmi.id', to: :xmi_id
    map_attribute 'xmi.label', to: :xmi_label
    map_attribute 'xmi.uuid', to: :xmi_uuid
    map_attribute 'href', to: :href
    map_attribute 'xmi.idref', to: :xmi_idref
    map_element 'Common_Behavior', to: :common_behavior
    map_element 'Collaborations', to: :collaborations
    map_element 'Use_Cases', to: :use_cases
    map_element 'State_Machines', to: :state_machines
  end
end
