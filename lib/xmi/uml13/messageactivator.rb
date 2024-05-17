require 'shale'

require_relative 'message'

class Messageactivator < Shale::Mapper
  attribute :message, Message, collection: true

  xml do
    root 'Message.activator'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Message', to: :message
  end
end
