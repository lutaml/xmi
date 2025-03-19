# frozen_string_literal: true

require_relative "lib/xmi/version"

Gem::Specification.new do |spec|
  spec.name          = "xmi"
  spec.version       = Xmi::VERSION
  spec.authors       = ["Ribose Inc."]
  spec.email         = ["open.source@ribose.com'"]

  spec.summary       = "XMI data model parser"
  spec.description   = "XMI data model parser"
  spec.homepage      = "https://github.com/lutaml/xmi"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/lutaml/xmi/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem
  # that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`
      .split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features|references)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.0.0"

  spec.add_runtime_dependency "lutaml-model", "~> 0.7"
  spec.add_runtime_dependency "nokogiri"

  spec.add_development_dependency "pry", "~> 0.12.2"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.11"
  spec.add_development_dependency "rspec-xml"
  spec.add_development_dependency "rubocop", "~> 1.58"
  # spec.add_development_dependency "xml-c14n"
end
