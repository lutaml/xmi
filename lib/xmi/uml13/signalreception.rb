require 'shale'

require_relative 'reception'

class Signalreception < Shale::Mapper
  attribute :reception, Reception, collection: true

  xml do
    root 'Signal.reception'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Reception', to: :reception
  end
end
