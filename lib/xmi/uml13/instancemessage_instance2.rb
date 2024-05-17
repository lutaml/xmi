require 'shale'

require_relative 'message_instance'

class InstancemessageInstance2 < Shale::Mapper
  attribute :message_instance, MessageInstance, collection: true

  xml do
    root 'Instance.messageInstance2'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'MessageInstance', to: :message_instance
  end
end
