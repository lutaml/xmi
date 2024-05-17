require 'shale'

require_relative 'message'

class ClassifierRolemessage < Shale::Mapper
  attribute :message, Message, collection: true

  xml do
    root 'ClassifierRole.message'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Message', to: :message
  end
end
