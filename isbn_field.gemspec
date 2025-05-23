# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "isbn_field"
  spec.version       = "0.1.2"
  spec.authors       = ["Worajedt Sitthidumrong"]
  spec.email         = ["jedt3d@gmail.com"]

  spec.summary       = "ISBN-10 and ISBN-13 validation gem"
  spec.description   = "A Ruby gem for validating ISBN-10 and ISBN-13 numbers"
  spec.homepage      = "https://github.com/Jedt3D/isbn_field"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.glob("{bin,lib}/**/*") + %w[LICENSE README.md]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rake", "~> 13.0"
end
