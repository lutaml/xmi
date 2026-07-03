# frozen_string_literal: true

require "spec_helper"
require_relative "../../../lib/xmi"

# PackagedElement subclass schemas. Dispatch behavior is covered in
# packaged_element_dispatch_spec.rb. This file locks in the schema
# (inheritance, no extra attrs in Phase A).
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "PackagedElement subclasses schema" do
  [
    Xmi::Uml::UmlClass,
    Xmi::Uml::Association,
    Xmi::Uml::AssociationClass,
    Xmi::Uml::Interface,
    Xmi::Uml::InstanceSpecification,
    Xmi::Uml::DataType,
    Xmi::Uml::PrimitiveType,
    Xmi::Uml::Enumeration,
    Xmi::Uml::Package,
    Xmi::Uml::Realization,
    Xmi::Uml::Dependency,
    Xmi::Uml::Signal,
    Xmi::Uml::Extension,
    Xmi::Uml::Stereotype,
    Xmi::Uml::Usage,
  ].each do |klass|
    describe klass do
      it "inherits from PackagedElement" do
        expect(described_class).to be < Xmi::Uml::PackagedElement
      end

      it "inherits the union-bag attribute set (Phase A)" do
        # Phase A: subclasses are type tags. All PackagedElement attrs
        # remain accessible via inheritance. Phase B (TODO.next/01)
        # will narrow these.
        expect(described_class.attributes).to have_key(:name)
        expect(described_class.attributes).to have_key(:packaged_element)
      end
    end
  end
end

# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
