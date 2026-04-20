# frozen_string_literal: true

require "spec_helper"

RSpec.describe Xmi::CustomProfile do
  expected_classes = %i[
    Bibliography BasicDoc Enumeration Ocl Invariant
    PublicationDate Edition Number YearVersion
    Informative Persistence Abstract
  ].freeze

  expected_classes.each do |klass_name|
    describe ".#{klass_name}" do
      let(:klass) { described_class.const_get(klass_name) }

      it "is a Serializable subclass" do
        expect(klass.ancestors).to include(Lutaml::Model::Serializable)
      end

      it "has at least one attribute" do
        expect(klass.attributes).not_to be_empty
      end
    end
  end
end
