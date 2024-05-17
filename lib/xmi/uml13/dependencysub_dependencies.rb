require 'shale'

require_relative 'binding'
require_relative 'dependency'
require_relative 'refinement'
require_relative 'trace'
require_relative 'usage'

class DependencysubDependencies < Shale::Mapper
  attribute :dependency, Dependency, collection: true
  attribute :refinement, Refinement, collection: true
  attribute :usage, Usage, collection: true
  attribute :trace, Trace, collection: true
  attribute :binding, Binding, collection: true

  xml do
    root 'Dependency.subDependencies'
    namespace 'omg.org/UML1.3', 'UML'

    map_element 'Dependency', to: :dependency
    map_element 'Refinement', to: :refinement
    map_element 'Usage', to: :usage
    map_element 'Trace', to: :trace
    map_element 'Binding', to: :binding
  end
end
