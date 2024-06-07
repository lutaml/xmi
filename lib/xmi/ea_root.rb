# frozen_string_literal: true

Dir[File.join(__dir__, "ea_extensions", "*.rb")].each { |file| require file }

module Xmi
  class EaRoot
    Dir[File.join(__dir__, "ea_extensions", "*.rb")].each do |f|
      include Xmi.const_get(File.basename(f, ".rb").capitalize)
    end
  end
end
