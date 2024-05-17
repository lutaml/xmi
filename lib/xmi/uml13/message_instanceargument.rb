require 'shale'

require_relative 'instance'

class MessageInstanceargument < Shale::Mapper
  attribute :instance, Instance, collection: true

  xml do
    root 'MessageInstance.argument'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Instance', to: :instance
  end
end
