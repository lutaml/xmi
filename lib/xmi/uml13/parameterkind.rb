require 'shale'

class Parameterkind < Shale::Mapper
  attribute :xmi_value, Shale::Type::String

  xml do
    root 'Parameter.kind'
    namespace 'omg.org/UML1.3', 'UML'

    map_attribute 'xmi.value', to: :xmi_value
  end
end
