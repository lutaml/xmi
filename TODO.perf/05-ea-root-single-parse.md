# 05: EaRoot Single Parse for Extension Loading

## Impact: LOW (only affects load_extension, not parse_xml hot path)

## Problem

`EaRoot.load_extension(xml_path)` reads and parses the XML file twice:
1. `derive_module_name` in `ea_root.rb:54-56` — `Nokogiri::XML(File.read(xml_path))`
2. `build_extension` in `code_generation.rb:8` — `Nokogiri::XML(File.read(xml_path))`

## Fix

Parse once in `load_extension`, pass the Nokogiri doc to both:

```ruby
def load_extension(xml_path)
  xmi_doc = Nokogiri::XML(File.read(xml_path))
  extension_id = get_module_name(xmi_doc)
  # ...guard...
  build_extension_from_doc(xmi_doc)
  update_mappings(extension_id)
  loaded_extensions[extension_id] = xml_path
end
```

## Files

- `lib/xmi/ea_root.rb` — parse once, pass doc
- `lib/xmi/ea_root/code_generation.rb` — accept doc parameter instead of file path
