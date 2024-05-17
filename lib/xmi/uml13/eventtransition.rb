require 'shale'

require_relative 'transition'

class Eventtransition < Shale::Mapper
  attribute :transition, Transition, collection: true

  xml do
    root 'Event.transition'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Transition', to: :transition
  end
end
