# frozen_string_literal: true

require "shale"

require_relative "activity_model"

class PartitionactivityModel < Shale::Mapper
  attribute :activity_model, ActivityModel, collection: true

  xml do
    root "Partition.activityModel"
    namespace "omg.org/UML1.3", "UML"

    map_element "ActivityModel", to: :activity_model
  end
end
