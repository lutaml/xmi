# frozen_string_literal: true

require "spec_helper"
require "xmi"

# PackagedElement subclass schemas. Dispatch behavior is covered in
# packaged_element_dispatch_spec.rb. This file locks in the schema
# (inheritance, no extra attrs in Phase A).
#
# Iterates PACKAGED_ELEMENT_POLYMORPHIC_MAP[:class_map] so adding a new
# subclass + map entry automatically gains schema coverage — OCP for
# the test layer.
#
# rubocop:disable RSpec/DescribeClass, RSpec/FilePath
RSpec.describe "PackagedElement subclasses schema" do
  # Trigger autoload of the file that defines both PackagedElement and
  # PACKAGED_ELEMENT_POLYMORPHIC_MAP.
  Xmi::Uml::PackagedElement

  Xmi::Uml::PACKAGED_ELEMENT_POLYMORPHIC_MAP[:class_map].each_value do |class_name|
    klass = Object.const_get(class_name)

    describe klass do
      it "inherits from PackagedElement" do
        expect(described_class).to be < Xmi::Uml::PackagedElement
      end

      it "inherits the union-bag attribute set (Phase A)" do
        # Phase A: subclasses are type tags. All PackagedElement attrs
        # remain accessible via inheritance. Phase B
        # will narrow these.
        expect(described_class.attributes).to have_key(:name)
        expect(described_class.attributes).to have_key(:packaged_element)
        expect(described_class.attributes).to have_key(:nested_classifier)
      end
    end
  end
end

# rubocop:enable RSpec/DescribeClass, RSpec/FilePath
