# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inistyle/version'

Gem::Specification.new do |spec|
  spec.name          = "inistyle"
  spec.version       = Inistyle::VERSION
  spec.authors       = ["Geoff Williams"]
  spec.email         = ["geoff.williams@puppetlabs.com"]

  spec.summary       = %q{Parse and write INI sytle files.}
  spec.description   = %q{Simplistic parsing of INI style files.  Data within sections can be handled as raw lines or as an array split on spaces.}
  spec.homepage      = "https://github.com/GeoffWilliams/inistyle"
  spec.license       = "Apache 2.0"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
