require 'shale'

require_relative 'instance'

class MessageInstancesender < Shale::Mapper
  attribute :instance, Instance, collection: true

  xml do
    root 'MessageInstance.sender'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Instance', to: :instance
  end
end
