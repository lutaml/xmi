# frozen_string_literal: true

require_relative "uml13/abstraction"
require_relative "uml13/action"
require_relative "uml13/action_sequence"
require_relative "uml13/action_sequenceaction"
require_relative "uml13/action_sequencestate"
require_relative "uml13/action_sequencestate2"
require_relative "uml13/action_sequencetransition"
require_relative "uml13/action_state"
require_relative "uml13/actionaction_sequence"
require_relative "uml13/actionactual_argument"
require_relative "uml13/actionis_asynchronous"
require_relative "uml13/actionmessage"
require_relative "uml13/actionrecurrence"
require_relative "uml13/actionrequest"
require_relative "uml13/actionscript"
require_relative "uml13/actiontarget"
require_relative "uml13/activity_model"
require_relative "uml13/activity_modelpartition"
require_relative "uml13/activity_state"
require_relative "uml13/actor"
require_relative "uml13/argument"
require_relative "uml13/argumentaction"
require_relative "uml13/argumentvalue"
require_relative "uml13/association"
require_relative "uml13/association_class"
require_relative "uml13/association_end"
require_relative "uml13/association_end_role"
require_relative "uml13/association_end_roleassociation_role"
require_relative "uml13/association_end_rolebase"
require_relative "uml13/association_endaggregation"
require_relative "uml13/association_endassociation"
require_relative "uml13/association_endassociation_end_role"
require_relative "uml13/association_endchangeable"
require_relative "uml13/association_endis_navigable"
require_relative "uml13/association_endis_ordered"
require_relative "uml13/association_endlink_end"
require_relative "uml13/association_endmultiplicity"
require_relative "uml13/association_endqualifier"
require_relative "uml13/association_endspecification"
require_relative "uml13/association_endtarget_scope"
require_relative "uml13/association_endtype"
require_relative "uml13/association_role"
require_relative "uml13/association_rolebase"
require_relative "uml13/association_rolemultiplicity"
require_relative "uml13/association_rolenamespace"
require_relative "uml13/associationassociation_end"
require_relative "uml13/associationconnection"
require_relative "uml13/associationlink"
require_relative "uml13/attribute"
require_relative "uml13/attribute_link"
require_relative "uml13/attribute_linkattribute"
require_relative "uml13/attribute_linkinstance"
require_relative "uml13/attribute_linkvalue"
require_relative "uml13/attributeassociation_end"
require_relative "uml13/attributeattribute_link"
require_relative "uml13/attributeinitial_value"
require_relative "uml13/auxiliary_elements"
require_relative "uml13/behavioral_elements"
require_relative "uml13/behavioral_feature"
require_relative "uml13/behavioral_featureis_query"
require_relative "uml13/behavioral_featureparameter"
require_relative "uml13/behavioral_featureraised_exception"
require_relative "uml13/binding"
require_relative "uml13/bindingargument"
require_relative "uml13/boolean_expression"
require_relative "uml13/call_action"
require_relative "uml13/call_actionmode"
require_relative "uml13/call_event"
require_relative "uml13/call_eventoperation"
require_relative "uml13/change_event"
require_relative "uml13/change_eventchange_expression"
require_relative "uml13/class"
require_relative "uml13/classifier"
require_relative "uml13/classifier_in_state"
require_relative "uml13/classifier_in_statein_state"
require_relative "uml13/classifier_in_stateobject_flow_state"
require_relative "uml13/classifier_in_statetype"
require_relative "uml13/classifier_role"
require_relative "uml13/classifier_roleassociation_end_role"
require_relative "uml13/classifier_roleavailable_feature"
require_relative "uml13/classifier_rolebase"
require_relative "uml13/classifier_rolemessage"
require_relative "uml13/classifier_rolemessage2"
require_relative "uml13/classifier_rolemultiplicity"
require_relative "uml13/classifier_rolenamespace"
require_relative "uml13/classifierassociation_end"
require_relative "uml13/classifierclassifier_in_state"
require_relative "uml13/classifierclassifier_role"
require_relative "uml13/classifiercollaboration"
require_relative "uml13/classifiercreate_action"
require_relative "uml13/classifierfeature"
require_relative "uml13/classifierinstance"
require_relative "uml13/classifierparameter"
require_relative "uml13/classifierparticipant"
require_relative "uml13/classifierrealization"
require_relative "uml13/classifierspecification"
require_relative "uml13/classifierstructural_feature"
require_relative "uml13/classis_active"
require_relative "uml13/collaboration"
require_relative "uml13/collaborationconstraining_element"
require_relative "uml13/collaborationinteraction"
require_relative "uml13/collaborationrepresented_classifier"
require_relative "uml13/collaborationrepresented_operation"
require_relative "uml13/collaborations"
require_relative "uml13/comment"
require_relative "uml13/common_behavior"
require_relative "uml13/component"
require_relative "uml13/componentdeployment"
require_relative "uml13/componentimplements"
require_relative "uml13/composite_state"
require_relative "uml13/composite_stateis_concurrent"
require_relative "uml13/composite_statesubstate"
require_relative "uml13/constraint"
require_relative "uml13/constraintbody"
require_relative "uml13/constraintconstrained_element"
require_relative "uml13/constraintconstrained_stereotype"
require_relative "uml13/core"
require_relative "uml13/create_action"
require_relative "uml13/create_actioninstantiation"
require_relative "uml13/data_type"
require_relative "uml13/data_types"
require_relative "uml13/data_value"
require_relative "uml13/dependency"
require_relative "uml13/dependencyclient"
require_relative "uml13/dependencydescription"
require_relative "uml13/dependencyowning_dependency"
require_relative "uml13/dependencysub_dependencies"
require_relative "uml13/dependencysupplier"
require_relative "uml13/destroy_action"
require_relative "uml13/diagram"
require_relative "uml13/diagram_compositions"
require_relative "uml13/diagram_element"
require_relative "uml13/diagram_element_properties"
require_relative "uml13/diagram_elementdiagram"
require_relative "uml13/diagram_elementgeometry"
require_relative "uml13/diagram_elementstyle"
require_relative "uml13/diagram_properties"
require_relative "uml13/diagramdiagram_type"
require_relative "uml13/diagramelement"
require_relative "uml13/diagramname"
require_relative "uml13/diagramowner"
require_relative "uml13/diagramstyle"
require_relative "uml13/diagramtool_name"
require_relative "uml13/element"
require_relative "uml13/element_reference"
require_relative "uml13/element_referencealias"
require_relative "uml13/element_referencepackage"
require_relative "uml13/element_referencereferenced_element"
require_relative "uml13/element_referencevisibility"
require_relative "uml13/enumeration"
require_relative "uml13/enumeration_literal"
require_relative "uml13/enumeration_literalenumeration"
require_relative "uml13/enumeration_literalname"
require_relative "uml13/enumerationliteral"
require_relative "uml13/event"
require_relative "uml13/eventstate"
require_relative "uml13/eventtransition"
require_relative "uml13/exception"
require_relative "uml13/exceptioncontext"
require_relative "uml13/expression"
require_relative "uml13/expressionbody"
require_relative "uml13/expressionlanguage"
require_relative "uml13/extension_mechanisms"
require_relative "uml13/feature"
require_relative "uml13/featureclassifier_role"
require_relative "uml13/featureowner"
require_relative "uml13/featureowner_scope"
require_relative "uml13/foundation"
require_relative "uml13/generalizable_element"
require_relative "uml13/generalizable_elementgeneralization"
require_relative "uml13/generalizable_elementis_abstract"
require_relative "uml13/generalizable_elementis_leaf"
require_relative "uml13/generalizable_elementis_root"
require_relative "uml13/generalizable_elementspecialization"
require_relative "uml13/generalization"
require_relative "uml13/generalizationdiscriminator"
require_relative "uml13/generalizationsubtype"
require_relative "uml13/generalizationsupertype"
require_relative "uml13/geometry"
require_relative "uml13/geometrybody"
require_relative "uml13/graphic_marker"
require_relative "uml13/graphic_markerbody"
require_relative "uml13/guard"
require_relative "uml13/guardexpression"
require_relative "uml13/guardtransition"
require_relative "uml13/instance"
require_relative "uml13/instanceattribute_link"
require_relative "uml13/instanceclassifier"
require_relative "uml13/instancelink_end"
require_relative "uml13/instancemessage_instance"
require_relative "uml13/instancemessage_instance2"
require_relative "uml13/instancemessage_instance3"
require_relative "uml13/instanceslot"
require_relative "uml13/interaction"
require_relative "uml13/interactioncontext"
require_relative "uml13/interactionmessage"
require_relative "uml13/interface"
require_relative "uml13/link"
require_relative "uml13/link_end"
require_relative "uml13/link_endassociation_end"
require_relative "uml13/link_endinstance"
require_relative "uml13/link_endlink"
require_relative "uml13/link_object"
require_relative "uml13/linkassociation"
require_relative "uml13/linklink_role"
require_relative "uml13/local_invocation"
require_relative "uml13/mapping"
require_relative "uml13/mappingbody"
require_relative "uml13/message"
require_relative "uml13/message_instance"
require_relative "uml13/message_instanceargument"
require_relative "uml13/message_instancereceiver"
require_relative "uml13/message_instancesender"
require_relative "uml13/message_instancespecification"
require_relative "uml13/messageaction"
require_relative "uml13/messageactivator"
require_relative "uml13/messageinteraction"
require_relative "uml13/messagemessage"
require_relative "uml13/messagemessage2"
require_relative "uml13/messagepredecessor"
require_relative "uml13/messagereceiver"
require_relative "uml13/messagesender"
require_relative "uml13/method"
require_relative "uml13/methodbody"
require_relative "uml13/methodspecification"
require_relative "uml13/model"
require_relative "uml13/model_element"
require_relative "uml13/model_element_owns_diagramowned_diagram"
require_relative "uml13/model_elementbehavior"
require_relative "uml13/model_elementbinding"
require_relative "uml13/model_elementcollaboration"
require_relative "uml13/model_elementconstraint"
require_relative "uml13/model_elementelement_reference"
require_relative "uml13/model_elementimplementation"
require_relative "uml13/model_elementname"
require_relative "uml13/model_elementnamespace"
require_relative "uml13/model_elementpartition"
require_relative "uml13/model_elementpresentation"
require_relative "uml13/model_elementprovision"
require_relative "uml13/model_elementrequirement"
require_relative "uml13/model_elementstereotype"
require_relative "uml13/model_elementtagged_value"
require_relative "uml13/model_elementtemplate"
require_relative "uml13/model_elementtemplate_parameter"
require_relative "uml13/model_elementview"
require_relative "uml13/model_elementvisibility"
require_relative "uml13/model_management"
require_relative "uml13/multiplicity_range"
require_relative "uml13/multiplicity_rangelower"
require_relative "uml13/multiplicity_rangeupper"
require_relative "uml13/namespace"
require_relative "uml13/namespaceowned_element"
require_relative "uml13/node"
require_relative "uml13/nodecomponent"
require_relative "uml13/object"
require_relative "uml13/object_flow_state"
require_relative "uml13/object_flow_statetype_state"
require_relative "uml13/object_set_expression"
require_relative "uml13/operation"
require_relative "uml13/operationcollaboration"
require_relative "uml13/operationconcurrency"
require_relative "uml13/operationis_polymorphic"
require_relative "uml13/operationmethod"
require_relative "uml13/operationoccurrence"
require_relative "uml13/operationspecification"
require_relative "uml13/package"
require_relative "uml13/packageelement_reference"
require_relative "uml13/parameter"
require_relative "uml13/parameterbehavioral_feature"
require_relative "uml13/parameterdefault_value"
require_relative "uml13/parameterkind"
require_relative "uml13/parametersignal"
require_relative "uml13/parametertype"
require_relative "uml13/partition"
require_relative "uml13/partitionactivity_model"
require_relative "uml13/partitioncontents"
require_relative "uml13/presentation"
require_relative "uml13/presentationgeometry"
require_relative "uml13/presentationmodel"
require_relative "uml13/presentationstyle"
require_relative "uml13/presentationview_element"
require_relative "uml13/primitive"
require_relative "uml13/procedure_expression"
require_relative "uml13/pseudo_state"
require_relative "uml13/pseudo_statekind"
require_relative "uml13/reception"
require_relative "uml13/receptionis_polymorphic"
require_relative "uml13/receptionsignal"
require_relative "uml13/receptionspecification"
require_relative "uml13/refinement"
require_relative "uml13/refinementmapping"
require_relative "uml13/request"
require_relative "uml13/requestaction"
require_relative "uml13/requestmessage_instance"
require_relative "uml13/return_action"
require_relative "uml13/send_action"
require_relative "uml13/signal"
require_relative "uml13/signal_event"
require_relative "uml13/signal_eventsignal"
require_relative "uml13/signaloccurrence"
require_relative "uml13/signalparameter"
require_relative "uml13/signalreception"
require_relative "uml13/simple_state"
require_relative "uml13/state"
require_relative "uml13/state_machine"
require_relative "uml13/state_machinecontext"
require_relative "uml13/state_machines"
require_relative "uml13/state_machinesubmachine_state"
require_relative "uml13/state_machinetop"
require_relative "uml13/state_machinetransitions"
require_relative "uml13/state_vertex"
require_relative "uml13/state_vertexincoming"
require_relative "uml13/state_vertexoutgoing"
require_relative "uml13/state_vertexparent"
require_relative "uml13/stateclassifier_in_state"
require_relative "uml13/statedeferred_event"
require_relative "uml13/stateentry"
require_relative "uml13/stateexit"
require_relative "uml13/stateinternal_transition"
require_relative "uml13/statestate_machine"
require_relative "uml13/stereotype"
require_relative "uml13/stereotypebase_class"
require_relative "uml13/stereotypeextended_element"
require_relative "uml13/stereotypeicon"
require_relative "uml13/stereotyperequired_tag"
require_relative "uml13/stereotypestereotype_constraint"
require_relative "uml13/structural_feature"
require_relative "uml13/structural_featurechangeable"
require_relative "uml13/structural_featuremultiplicity"
require_relative "uml13/structural_featuretarget_scope"
require_relative "uml13/structural_featuretype"
require_relative "uml13/structure"
require_relative "uml13/submachine_state"
require_relative "uml13/submachine_statestate_machine"
require_relative "uml13/subsystem"
require_relative "uml13/subsystemis_instantiable"
require_relative "uml13/tagged_value"
require_relative "uml13/tagged_valuemodel_element"
require_relative "uml13/tagged_valuestereotype"
require_relative "uml13/tagged_valuetag"
require_relative "uml13/tagged_valuevalue"
require_relative "uml13/terminate_action"
require_relative "uml13/time_event"
require_relative "uml13/time_eventduration"
require_relative "uml13/time_expression"
require_relative "uml13/trace"
require_relative "uml13/transition"
require_relative "uml13/transitioneffect"
require_relative "uml13/transitionguard"
require_relative "uml13/transitionsource"
require_relative "uml13/transitionstate"
require_relative "uml13/transitionstatemachine"
require_relative "uml13/transitiontarget"
require_relative "uml13/transitiontrigger"
require_relative "uml13/uninterpreted_action"
require_relative "uml13/uninterpreted_actionbody"
require_relative "uml13/usage"
require_relative "uml13/use_case"
require_relative "uml13/use_case_instance"
require_relative "uml13/use_caseextension_point"
require_relative "uml13/use_cases"
require_relative "uml13/view_element"
require_relative "uml13/view_elementmodel"
require_relative "uml13/view_elementpresentation"
require_relative "uml13/xm_iextension"
require_relative "uml13/xm_ireference"