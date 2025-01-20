# frozen_string_literal: true

require "lutaml/model"
require "lutaml/model/xml_adapter/nokogiri_adapter"
# require "lutaml/model/json_adapter/standard_json_adapter"
# require "lutaml/model/yaml_adapter/standard_yaml_adapter"

Lutaml::Model::Config.configure do |config|
  config.xml_adapter = Lutaml::Model::XmlAdapter::NokogiriAdapter
  # config.yaml_adapter = Lutaml::Model::YamlAdapter::StandardYamlAdapter
  # config.json_adapter = Lutaml::Model::JsonAdapter::StandardJsonAdapter
end

module Lutaml
  module Model
    class Serializable
      def type?(test_type)
        !!type ? type == test_type : false
      end
    end
  end
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
require_relative "xmi/ea_root"
require_relative "xmi/uml"
require_relative "xmi/the_custom_profile"
require_relative "xmi/root"
require_relative "xmi/sparx"
