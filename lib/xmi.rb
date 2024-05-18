# frozen_string_literal: true

require "shale"

unless Shale.xml_adapter
  require "shale/adapter/nokogiri"
  Shale.xml_adapter = Shale::Adapter::Nokogiri
end

require_relative "xmi/version"

module Xmi
  class Error < StandardError; end
  # Your code goes here...
end

require_relative "xmi/add"
require_relative "xmi/delete"
require_relative "xmi/difference"
require_relative "xmi/documentation"
require_relative "xmi/extension"
require_relative "xmi/replace"
require_relative "xmi/uml"
require_relative "xmi/root"
require_relative "xmi/sparx"
# require_relative "xmi/uml13"
