#!/usr/bin/env ruby
# frozen_string_literal: true

#
# This script is used to generate Shale Class definition for Enterprise
# Architect from XML profile definition file
#

require "fileutils"
require "nokogiri"
require "optparse"

MODULE_TEMPLATE = <<~TEXT
# frozen_string_literal: true

module Xmi
  module #MODULE_NAME#
#KLASSES#
  end
end
TEXT

KLASS_TEMPLATE = <<~TEXT
    class #KLASS_NAME# < #FROM_KLASS#
#ATTRIBUTES##XML_MAPPING#
    end
TEXT

XML_MAPPING = <<~TEXT
      xml do
        root "#ROOT_TAG#"
#MAP_ATTRIBUTES#
      end
TEXT

ATTRIBUTE_LINE = <<~TEXT
attribute :#TAG_NAME#, #ATTRIBUTE_TYPE#
TEXT

MAP_ATTRIBUTES = <<~TEXT
map_attribute "#ATTRIBUTE_NAME#", to: :#ATTRIBUTE_METHOD#
TEXT

def set_abstract_klass_node(xmi_doc)
  @abstract_klass_node = xmi_doc.at_xpath(
    "//UMLProfiles//Stereotypes//Stereotype[@isAbstract='true']"
  )
end

def get_klass_name_from_node(node)
  node.attribute_nodes.find { |attr| attr.name == "name" }.value
end

def proper_klass_name(klass_name)
  klass_name.split("_").map(&:downcase).map(&:capitalize).join
end

def gen_map_attribute_line(attr_name, attr_method)
  space_before = " " * 8

  map_attributes = MAP_ATTRIBUTES
                   .gsub("#ATTRIBUTE_NAME#", attr_name)
                   .gsub("#ATTRIBUTE_METHOD#", attr_method.downcase)

  "#{space_before}#{map_attributes}"
end

def gen_attribute_line(tag_name, attribute_type = "Shale::Type::String")
  tag_name = tag_name.downcase
  space_before = " " * 6

  attribute_line = ATTRIBUTE_LINE
                   .gsub("#TAG_NAME#", tag_name)
                   .gsub("#ATTRIBUTE_TYPE#", attribute_type)

  "#{space_before}#{attribute_line}"
end

def get_tag_name(tag)
  tag.attribute_nodes.find { |attr| attr.name == "name" }.value
end

def gen_tags(node)
  tags = node.search("Tag")
  attributes_lines = ""

  tags.each do |tag|
    tag_name = get_tag_name(tag)
    attributes_lines += gen_attribute_line(tag_name)
  end

  [attributes_lines, tags]
end

def gen_abstract_klass
  attributes_lines = ""
  tags_lines, @abstract_tags = gen_tags(@abstract_klass_node)
  attributes_lines += tags_lines
  klass_name = get_klass_name_from_node(@abstract_klass_node)

  KLASS_TEMPLATE
    .gsub("#KLASS_NAME#", proper_klass_name(klass_name))
    .gsub("#FROM_KLASS#", "Shale::Mapper")
    .gsub("#ATTRIBUTES#", attributes_lines.rstrip)
    .gsub("#XML_MAPPING#", "")
end

def gen_apply_types(node)
  apply_types_lines = ""
  apply_types_nodes = node.search("Apply")
  apply_types_nodes.each do |n|
    apply_types = n.attribute_nodes.map(&:value)
    apply_types.each do |apply_type|
      tag_name = "base_#{apply_type}"
      apply_types_lines += gen_attribute_line(tag_name)
    end
  end

  [apply_types_lines, apply_types_nodes]
end

def gen_generic_klass(node)
  node_name = get_klass_name_from_node(node)
  abstract_klass_name = get_klass_name_from_node(@abstract_klass_node)
  attributes_lines = ""
  map_attributes_lines = ""

  # tags
  tags_lines, tags = gen_tags(node)
  attributes_lines += tags_lines
  (@abstract_tags + tags).each do |tag|
    tag_name = get_tag_name(tag)
    map_attributes_lines += gen_map_attribute_line(tag_name, tag_name)
  end

  # apply types
  apply_types_lines, apply_types_nodes = gen_apply_types(node)
  unless apply_types_nodes.empty?
    attributes_lines += apply_types_lines
    apply_types_nodes.each do |n|
      apply_types = n.attribute_nodes.map(&:value)
      apply_types.each do |apply_type|
        tag_name = "base_#{apply_type}"
        map_attributes_lines += gen_map_attribute_line(tag_name, tag_name)
      end
    end
  end

  xml_mapping = XML_MAPPING
                .gsub("#ROOT_TAG#", node_name)
                .gsub("#MAP_ATTRIBUTES#", "\n#{map_attributes_lines.rstrip}")
                .rstrip

  KLASS_TEMPLATE
    .gsub("#KLASS_NAME#", proper_klass_name(node_name))
    .gsub("#FROM_KLASS#", proper_klass_name(abstract_klass_name))
    .gsub("#ATTRIBUTES#", attributes_lines.rstrip)
    .gsub("#XML_MAPPING#", "\n\n#{xml_mapping}")
end

def gen_generic_klasses(xmi_doc)
  nodes = xmi_doc.xpath(
    "//UMLProfiles//Stereotypes//Stereotype[not(contains(@isAbstract, 'true'))]"
  )
  klasses_lines = ""

  nodes.each do |node|
    # check baseStereotypes is abstract class
    base_stereotypes = node.attribute_nodes.find do |attr|
      attr.name == "baseStereotypes" &&
        attr.value == get_klass_name_from_node(@abstract_klass_node)
    end
    next if base_stereotypes.nil?

    klasses_lines += "#{gen_generic_klass(node)}\n"
  end

  klasses_lines
end

def gen_klasses(xmi_doc)
  set_abstract_klass_node(xmi_doc)
  klasses_lines = ""
  klasses_lines += "#{gen_abstract_klass}\n"
  klasses_lines += gen_generic_klasses(xmi_doc).rstrip
  klasses_lines
end

def gen_module(xmi_doc, module_name)
  MODULE_TEMPLATE
    .gsub("#MODULE_NAME#", module_name)
    .gsub("#KLASSES#", gen_klasses(xmi_doc))
end

def gen_content(options)
  xml = options[:input_xml_path]
  module_name = options[:module_name]
  if options[:output_rb_path]
    module_name = File.basename(options[:output_rb_path], ".rb").capitalize
  end

  xmi_doc = Nokogiri::XML(File.open(xml).read)
  gen_module(xmi_doc, module_name)
end

def output_on_screen(content)
  puts "Output on screen:"
  puts "=" * 60
  puts content
  puts "=" * 60
end

def output_rb_file(content, output_rb_path)
  File.open(output_rb_path, "w") { |file| file.write(content) }
end

def output(content, output_rb_path = nil)
  output_on_screen(content)
  output_rb_file(content, output_rb_path) if output_rb_path
end

def main(options)
  content = gen_content(options)
  output(content, options[:output_rb_path])
end

options = {}
OptionParser.new do |opts|
  # Set sample options
  # options = {
  #   input_xml_path: "spec/fixtures/ISO19103MDG v1.0.0-beta.xml",
  #   output_rb_path: "lib/xmi/ea_extensions/mdg.rb"
  # }

  opts.banner = "Usage: gen_ea_ext.rb [options]"

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end

  opts.on(
    "-i INPUT_XML_PATH",
    "--input=INPUT_XML_PATH",
    "Path to XML profile definition file"
  ) do |i|
    options[:input_xml_path] = i
  end

  opts.on(
    "-o OUTPUT_RB_PATH",
    "--output=OUTPUT_RB_PATH",
    "Path to output the ruby file"
  ) do |o|
    options[:output_rb_path] = o
  end

  opts.on(
    "-m MODULE_NAME",
    "--module=MODULE_NAME",
    "Name of the module"
  ) do |m|
    options[:module_name] = m
  end
end.parse!

pp options

if options[:input_xml_path].nil? ||
   (options[:output_rb_path].nil? && options[:module_name].nil?)
  puts "Please specify the options!"
  exit
end

main(options)
