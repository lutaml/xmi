require 'shale'

require_relative 'message_instance'

class InstancemessageInstance3 < Shale::Mapper
  attribute :message_instance, MessageInstance, collection: true

  xml do
    root 'Instance.messageInstance3'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'MessageInstance', to: :message_instance
  end
end
