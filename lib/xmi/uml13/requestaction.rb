require 'shale'

require_relative 'action'

class Requestaction < Shale::Mapper
  attribute :action, Action, collection: true

  xml do
    root 'Request.action'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Action', to: :action
  end
end
