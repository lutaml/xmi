# frozen_string_literal: true

# Shared test data for extension loading specs (CityGML, ISO19103 MDG, etc.)
# Extracted from the three nearly-identical CityGML fixture specs.

module CityGmlShared
  KLASSES = %i[
    FeatureType CodeList Leaf ObjectType BasicType
    TopLevelFeatureType Union Property Version ApplicationSchema DataType
  ].sort.freeze

  # [attribute, method, expected_value] tuples for cross-checking parsed instances
  INSTANCES = [
    [:application_schema, :base_package,
     "EAPK_1C8607D1_2967_44ff_948A_2A9256D00A45"],
    [:code_list, :base_class, "EAID_63F44B99_981E_41ba_8BF9_0B7231BD321A"],
    [:property, :base_property, "EAID_08C9C0B1_5EF2_498b_9615_D83FFF295CE4"],
    [:feature_type, :base_class, "EAID_D8E4EAFC_9DAF_4cba_9169_984738657435"],
    [:top_level_feature_type, :base_class,
     "EAID_645EA139_9F9D_4caf_90C3_3455836FA55B"],
    [:data_type, :base_data_type, "EAID_4661534F_B67D_46b5_BC56_CEED3792F85B"],
    [:version, :base_property, "EAID_dst1B1F37_56A4_4908_B024_75F617AEE928"],
    [:basic_type, :base_class, "EAID_055FE569_234B_47f8_A8E7_362220BEB016"],
    [:object_type, :base_class, "EAID_18E08BBD_DC0E_409a_AA6E_49C20958C49B"],
    [:union, :base_data_type, "EAID_642E4231_E915_485f_94E6_A235CF1B5580"],
  ].freeze
end

module Iso19103Shared
  KLASSES = %i[
    AbstractSchema GI_DataType GI_Enumeration GI_EnumerationLiteral
    GI_Interface GI_Property GI_Element GI_Class GI_CodeSet Leaf Union CodeList
  ].sort.freeze

  INSTANCES = [
    [:abstract_schema, :base_package,
     "EAPK_63F21616_57B0_4ffc_A785_8FB5B49C27F1"],
    [:gi_interface, :base_interface,
     "EAID_1EA35B7C_1E09_4fe5_B75D_515CA12171B9"],
    [:gi_property, :base_property, "EAID_2A7400AC_F474_4063_A5B9_5C5305020D60"],
    [:gi_enumeration, :base_enumeration,
     "EAID_5AC15946_7E2E_4d2e_8208_300138B764C9"],
    [:gi_enumeration_literal, :base_enumeration_literal,
     "EAID_44EAA54D_A02D_4263_9EBF_C67721A40BAA"],
  ].freeze
end

module XmiExtensionShared
  ORIG_ATTRIBUTES = %i[
    id label uuid href idref type extension
    publication_date edition number year_version modelica_parameter
  ].sort.freeze

  ORIG_XML_MAPPING = %w[
    http://www.omg.org/spec/XMI/20131001:Documentation
    http://www.omg.org/spec/XMI/20131001:Model
    http://www.omg.org/spec/XMI/20131001:Extension
    http://www.omg.org/spec/XMI/20131001:publicationDate
    http://www.omg.org/spec/XMI/20131001:edition
    http://www.omg.org/spec/XMI/20131001:number
    http://www.omg.org/spec/XMI/20131001:yearVersion
    http://www.omg.org/spec/XMI/20131001:ModelicaParameter
  ].freeze
end
