# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "codebreaker/version"

Gem::Specification.new do |spec|
  spec.name          = "rg-codebreaker"
  spec.version       = Codebreaker::VERSION
  spec.authors       = ["VKuzmich"]
  spec.email         = ["vjk1976@ukr.net"]

  spec.summary       = %q{Write a short summary, because RubyGems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = 'https://github.com/VKuzmich/rg-codebreaker'
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "Set to 'http://rubygems.org'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = 'https://github.com/VKuzmich/rg-codebreaker'
  spec.metadata["changelog_uri"] = 'https://github.com/VKuzmich/rg-codebreaker/blob/master/README.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'byebug', '~> 11.0.1'
  spec.add_development_dependency 'fasterer', '~> 0.5.1'
  spec.add_development_dependency 'i18n', '~> 1.6'
  spec.add_development_dependency 'pry-byebug', '~> 3.7.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.71.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.33'
  spec.add_development_dependency 'simplecov', '~> 0.16.1'

end
