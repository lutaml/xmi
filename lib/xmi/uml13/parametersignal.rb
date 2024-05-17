require 'shale'

require_relative 'signal'

class Parametersignal < Shale::Mapper
  attribute :signal, Signal, collection: true

  xml do
    root 'Parameter.signal'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Signal', to: :signal
  end
end
