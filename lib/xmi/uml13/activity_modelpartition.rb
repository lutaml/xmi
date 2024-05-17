require 'shale'

require_relative 'partition'

class ActivityModelpartition < Shale::Mapper
  attribute :partition, Partition, collection: true

  xml do
    root 'ActivityModel.partition'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Partition', to: :partition
  end
end
