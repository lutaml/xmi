# frozen_string_literal: true

# Shared attribute declarations for Profile-like classes.
# Mixed into Profile via `include ProfileAttributes`.
module Xmi
  module Uml
    module ProfileAttributes
      def self.included(klass)
        klass.class_eval do
          attribute :packaged_element, PackagedElement, collection: true
          attribute :package_import, PackageImport, collection: true
          attribute :id, ::Xmi::Type::XmiId
          attribute :name, :string
          attribute :ns_prefix, :string
          attribute :metamodel_reference, :string
        end
      end
    end
  end
end
