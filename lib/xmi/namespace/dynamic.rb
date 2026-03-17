# frozen_string_literal: true

module Xmi
  module Namespace
    # Module for dynamically created namespace classes
    # These are created when loading EA MDG extensions
    module Dynamic
      class << self
        # Ensure the Dynamic namespace module exists
        # This is a no-op since the module is already defined
        def ensure_exists!
          # Already defined by Ruby when this file is loaded
        end
      end
    end
  end
end

# Add convenience method to parent module
module Xmi
  module Namespace
    class << self
      def ensure_dynamic_namespace_module_exists!
        Dynamic.ensure_exists!
      end
    end
  end
end
