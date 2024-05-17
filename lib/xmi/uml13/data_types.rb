require 'shale'

require_relative 'boolean_expression'
require_relative 'enumeration'
require_relative 'enumeration_literal'
require_relative 'expression'
require_relative 'geometry'
require_relative 'graphic_marker'
require_relative 'mapping'
require_relative 'multiplicity_range'
require_relative 'object_set_expression'
require_relative 'primitive'
require_relative 'procedure_expression'
require_relative 'structure'
require_relative 'time_expression'

class DataTypes < Shale::Mapper
  attribute :xmi_id, Shale::Type::Value
  attribute :xmi_label, Shale::Type::Value
  attribute :xmi_uuid, Shale::Type::Value
  attribute :href, Shale::Type::Value
  attribute :xmi_idref, Shale::Type::Value
  attribute :enumeration, Enumeration, collection: true
  attribute :enumeration_literal, EnumerationLiteral, collection: true
  attribute :primitive, Primitive, collection: true
  attribute :structure, Structure, collection: true
  attribute :multiplicity_range, MultiplicityRange, collection: true
  attribute :geometry, Geometry, collection: true
  attribute :graphic_marker, GraphicMarker, collection: true
  attribute :mapping, Mapping, collection: true
  attribute :expression, Expression, collection: true
  attribute :procedure_expression, ProcedureExpression, collection: true
  attribute :object_set_expression, ObjectSetExpression, collection: true
  attribute :time_expression, TimeExpression, collection: true
  attribute :boolean_expression, BooleanExpression, collection: true

  xml do
    root 'Data_Types'
    namespace 'omg.org/UML1.3', 'UML'

    map_attribute 'xmi.id', to: :xmi_id
    map_attribute 'xmi.label', to: :xmi_label
    map_attribute 'xmi.uuid', to: :xmi_uuid
    map_attribute 'href', to: :href
    map_attribute 'xmi.idref', to: :xmi_idref
    map_element 'Enumeration', to: :enumeration
    map_element 'EnumerationLiteral', to: :enumeration_literal
    map_element 'Primitive', to: :primitive
    map_element 'Structure', to: :structure
    map_element 'MultiplicityRange', to: :multiplicity_range
    map_element 'Geometry', to: :geometry
    map_element 'GraphicMarker', to: :graphic_marker
    map_element 'Mapping', to: :mapping
    map_element 'Expression', to: :expression
    map_element 'ProcedureExpression', to: :procedure_expression
    map_element 'ObjectSetExpression', to: :object_set_expression
    map_element 'TimeExpression', to: :time_expression
    map_element 'BooleanExpression', to: :boolean_expression
  end
end
