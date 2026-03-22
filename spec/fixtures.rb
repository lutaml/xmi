# frozen_string_literal: true

# Central registry of fixture files and their namespace versions.
# All integration tests should use this to self-document what they test.

module XmiFixtures
  # XMI model fixtures: [xmi_ns, uml_ns, umldi_ns, umldc_ns]
  MODEL_FIXTURES = {
    "ea-xmi-2.4.2.xmi" => ["20110701", "20110701", nil, nil],
    "ea-xmi-2.5.1.xmi" => ["20110701", "20110701", nil, nil],
    "xmi-v2-4-2-default.xmi" => ["20131001", "20131001", "20131001",
                                 "20131001"],
    "xmi-v2-4-2-default-with-citygml.xmi" => ["20110701", "20110701", nil, nil],
    "xmi-v2-4-2-default-with-eauml.xmi" => ["20110701", "20110701", nil, nil],
    "xmi-v2-4-2-default-with-gml.xmi" => ["20110701", "20110701", nil, nil],
    "full-242.xmi" => ["20110701", "20110701", nil, nil],
    "large_test.xmi" => ["20131001", "20161101", nil, nil],
    "ISO 6709 Edition 2.xml" => ["20131001", "20161101", "20161101",
                                 "20161101"],
    "Xamples.xmi" => ["20131001", "20161101", "20131001", "20131001"],
    "Common types.xml" => ["20131001", "20161101", "20131001", "20131001"],
  }.freeze

  # MDG definition fixtures: fixture name => extension module name
  MDG_FIXTURES = {
    "CityGML_MDG_Technology.xml" => :Citygml,
    "ISO19103MDG v1.0.0-beta.xml" => :Iso19103,
    "GML.xml" => :Gml,
    "EAUML.xml" => :Eauml,
  }.freeze

  def self.fixture_versions(name)
    MODEL_FIXTURES[name]
  end

  def self.mdg_extension(name)
    MDG_FIXTURES[name]
  end
end
