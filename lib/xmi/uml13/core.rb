require 'shale'

require_relative 'association'
require_relative 'association_class'
require_relative 'association_end'
require_relative 'attribute'
require_relative 'behavioral_feature'
require_relative 'class'
require_relative 'classifier'
require_relative 'constraint'
require_relative 'data_type'
require_relative 'dependency'
require_relative 'element'
require_relative 'feature'
require_relative 'generalizable_element'
require_relative 'generalization'
require_relative 'interface'
require_relative 'method'
require_relative 'model_element'
require_relative 'namespace'
require_relative 'operation'
require_relative 'parameter'
require_relative 'structural_feature'

class Core < Shale::Mapper
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :element, Element, collection: true
  attribute :model_element, ModelElement, collection: true
  attribute :namespace, Namespace, collection: true
  attribute :generalizable_element, GeneralizableElement, collection: true
  attribute :classifier, Classifier, collection: true
  attribute :interface, Interface, collection: true
  attribute :class, Class, collection: true
  attribute :data_type, DataType, collection: true
  attribute :feature, Feature, collection: true
  attribute :structural_feature, StructuralFeature, collection: true
  attribute :behavioral_feature, BehavioralFeature, collection: true
  attribute :operation, Operation, collection: true
  attribute :method, Method, collection: true
  attribute :parameter, Parameter, collection: true
  attribute :constraint, Constraint, collection: true
  attribute :dependency, Dependency, collection: true
  attribute :generalization, Generalization, collection: true
  attribute :association_end, AssociationEnd, collection: true
  attribute :association, Association, collection: true
  attribute :association_class, AssociationClass, collection: true
  attribute :attribute, Attribute, collection: true

  xml do
    root 'Core'
    namespace 'omg.org/UML1.3', 'UML'

    map_attribute 'xmi.id', to: :xmi_id
    map_attribute 'xmi.label', to: :xmi_label
    map_attribute 'xmi.uuid', to: :xmi_uuid
    map_attribute 'href', to: :href
    map_attribute 'xmi.idref', to: :xmi_idref
    map_element 'Element', to: :element
    map_element 'ModelElement', to: :model_element
    map_element 'Namespace', to: :namespace
    map_element 'GeneralizableElement', to: :generalizable_element
    map_element 'Classifier', to: :classifier
    map_element 'Interface', to: :interface
    map_element 'Class', to: :class
    map_element 'DataType', to: :data_type
    map_element 'Feature', to: :feature
    map_element 'StructuralFeature', to: :structural_feature
    map_element 'BehavioralFeature', to: :behavioral_feature
    map_element 'Operation', to: :operation
    map_element 'Method', to: :method
    map_element 'Parameter', to: :parameter
    map_element 'Constraint', to: :constraint
    map_element 'Dependency', to: :dependency
    map_element 'Generalization', to: :generalization
    map_element 'AssociationEnd', to: :association_end
    map_element 'Association', to: :association
    map_element 'AssociationClass', to: :association_class
    map_element 'Attribute', to: :attribute
  end
end
