require 'shale'

require_relative 'message'

class Messagepredecessor < Shale::Mapper
  attribute :message, Message, collection: true

  xml do
    root 'Message.predecessor'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Message', to: :message
  end
end
