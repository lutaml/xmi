RSpec.describe Xmi::Root do
  # it "does something useful" do
  #   yaml = Xmi::Root.from_xml(File.read("references/ConceptualModels/Possible Excess Model Elements.xml")).to_yaml
  #   expect(yaml).to_not be_nil
  # end

  # f = "references/ConceptualModels/Possible Excess Model Elements.xml"
  # id = "ConceptualModels/Possible Excess Model Elements.xml"
  # to_skip = false
  # it "round-trips OMG UML 1.3 XMI file: #{id}", skip: to_skip do
  #   input = File.read(f)

  #   output = Xmi::Root13.from_xml(input).to_xml(
  #     pretty: true,
  #     declaration: true,
  #     encoding: "utf-8",
  #   )

  #   expect(output).to be_analogous_with(input)
  # end

  f = "spec/fixtures/ISO 6709 Edition 2.xml"
  id = "ISO 6709 Edition 2.xml"
  to_skip = false
  it "round-trips OMG UML 2.5.1 XMI file: #{id} with diff", skip: to_skip do
    input = File.read(f).gsub("\t", "  ")

    output = Xmi::Root.from_xml(input).to_xml(
      pretty: true,
      declaration: true,
      encoding: "utf-8",
    )

    expect(output).to be_equivalent_to(input)
  end

  it "round-trips OMG UML 2.5.1 XMI file: #{id} with compare", skip: to_skip do
    input = File.read(f).gsub("\t", "  ")

    output = Xmi::Root.from_xml(input).to_xml(
      pretty: true,
      declaration: true,
      encoding: "utf-8",
    )

    expect(output).to be_analogous_with(input)
  end

end